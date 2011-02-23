Capistrano::Configuration.instance(:must_exist).load do
  after "deploy",            "deploy:track"
  after "deploy:migrations", "deploy:track"

  namespace :deploy do
    desc "Send deployment to deploytracker.com"
    task :track, :except => { :no_release => true } do
      data = {}
      data['user_email']      = fetch(:email, `git config --get user.email`.chomp)
      data['github_username'] = fetch(:github_username, `git config --get github.user`.chomp)
      data['environment']     = fetch(:rails_env, "production")
      data['revision']        = fetch(:current_revision)
      data['repository']      = fetch(:repository)
      data['source']          = fetch(:source, 'capistrano')
      data['branch']          = fetch(:branch, 'master')

      DeployTracker.notify(fetch(:deploy_tracking_api_key), data)
    end
  end
end