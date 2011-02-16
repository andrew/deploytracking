require 'net/https'
# hack to eliminate the SSL certificate verification notification
class Net::HTTP
  alias_method :old_initialize, :initialize
  def initialize(*args)
    old_initialize(*args)
    @ssl_context = OpenSSL::SSL::SSLContext.new
    @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end

Capistrano::Configuration.instance(:must_exist).load do
  after "deploy",            "deploy:track"
  after "deploy:migrations", "deploy:track"

  namespace :deploy do
    desc "Send deployment to deploytracker.com"
    task :track, :except => { :no_release => true } do
      rails_env = fetch(:rails_env, "production")
      executable = RUBY_PLATFORM.downcase.include?('mswin') ? 'rake.bat' : 'rake'

      puts "[DeployTracker] Tracking Deployment"

      email = `git config --get user.email`.chomp
      throw "[DeployTracker] Please set your email with...\n\t`git config --global user.email YOUR_EMAIL_ADDRESS`." if email.size==0
      github_username = `git config --get github.user`.chomp
      throw "[DeployTracker] Please set your github username with...\n\t`git config --global github.user YOUR_GITHUB_USERNAME`." if github_username.size==0

      data = "deploy[github_username]=#{github_username}&deploy[environment]=#{rails_env}&deploy[revision]=#{current_revision}&deploy[repository]=#{repository}&api_key=#{deploy_tracking_api_key}&deploy[source]=capistrano&deploy[branch]=#{branch}&deploy[user_email]=#{email}"

      http = Net::HTTP.new('deploytracking.heroku.com', 443)
      http.use_ssl = true
      path = '/deploys'

      headers = {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      resp, data = begin
                   http.post(path, data, headers)
                 rescue TimeoutError => e
                   throw "[DeployTracker] Connection timed out."
                 end
      throw "[DeployTracker] Error posting to server." unless resp.is_a?(Net::HTTPSuccess)
      puts "[DeployTracker] Deployment tracked"
    end
  end
end
