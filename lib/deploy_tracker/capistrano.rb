# partially borrowed from hoptoad_notifier

Capistrano::Configuration.instance(:must_exist).load do
  before "deploy",            "deploy:track"
  # after "deploy:migrations", "deploy:track"

  namespace :deploy do
    desc "Send deployment to deploytracker.com"
    task :track, :except => { :no_release => true } do
      rails_env = fetch(:rails_env, "production")
      local_user = ENV['USER'] || ENV['USERNAME']
      executable = RUBY_PLATFORM.downcase.include?('mswin') ? 'rake.bat' : 'rake'
      notify_command = "#{executable} deploy_tracker:notify ENV=#{rails_env} REVISION=#{current_revision} REPO=#{repository} USER=#{local_user}"
      puts "Tracking Deployment"
      `#{notify_command}`
      puts "Successfully Tracked Deployment."
    end
  end
end
