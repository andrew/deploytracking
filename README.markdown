Deploy Tracker
==============

Capistrano plugin for <http://deploytracking.com>

Rails 3 Install
---------------

In your Gemfile add:

    gem 'deploy_tracker'

Place the following line at the bottom config/deploy.rb:

    set :deploy_tracking_api_key, 'YOURAPIKEY'
    require 'config/boot'
    require 'deploy_tracker/capistrano'

Then run:

    bundle install

Sinatra/Rails 2 Install
-----------------------

Install the gem:

    gem install deploy_tracker

Place the following line at the bottom config/deploy.rb:

    set :deploy_tracking_api_key, 'YOURAPIKEY'
    require 'deploy_tracker/capistrano'

Note on Patches/Pull Requests
-----------------------------

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don't break it in a
   future version unintentionally.
 * Commit, do not mess with rakefile, version, or history.
   (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
 * Send me a pull request. Bonus points for topic branches.

Copyright
---------


Copyright (c) 2011 Andrew Nesbitt. See LICENSE for details.