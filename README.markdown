Deploy Tracker
==============

Capistrano plugin for <http://deploytracking.com>

[![Gem Version](https://badge.fury.io/rb/deploytracking.png)](http://badge.fury.io/rb/deploytracking)
[![Build Status](https://secure.travis-ci.org/andrew/deploytracking.png?branch=master)](http://travis-ci.org/andrew/deploytracking)
[![Dependency Status](https://gemnasium.com/andrew/deploytracking.png)](https://gemnasium.com/andrew/deploytracking)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/andrew/deploytracking)
Install
---------------

In your Gemfile add:

```ruby
gem 'deploytracking'
```

Place the following line at the bottom config/deploy.rb:

```ruby
set :deploy_tracking_api_key, 'YOURAPIKEY'
require 'deploytracking/capistrano'
```

Then run:

```bash
bundle install
```

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

Copyright (c) 2013 Andrew Nesbitt. See LICENSE for details.