require 'deploytracking'
Capistrano::Configuration.instance(:must_exist).load do
  after "deploy",            "deploy:track"
  after "deploy:migrations", "deploy:track"

  namespace :deploy do
    desc "Send deployment to deploytracker.com"
    task :track, :except => { :no_release => true } do
      api_key = fetch :deploy_tracking_api_key do
        puts "No DeployTracking API key present, get yours at #{DeployTracking::DEPLOY_TRACKING_HOST}"
      end

      data = {}
      data['user_email']      = fetch(:email, `git config --get user.email`.chomp)
      data['github_username'] = fetch(:github_username, `git config --get github.user`.chomp)
      data['environment']     = fetch(:rails_env, "production")
      data['revision']        = fetch(:current_revision)
      data['repository']      = fetch(:repository)
      data['source']          = fetch(:deploy_source, 'capistrano')
      data['branch']          = fetch(:branch, 'master')

      DeployTracking.notify(api_key, data) if api_key
    end
  end
end