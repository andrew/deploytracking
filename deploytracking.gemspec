# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deploytracking/version"

Gem::Specification.new do |s|
  s.name        = "deploytracking"
  s.version     = DeployTracking::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Nesbitt"]
  s.email       = ["andrewnez@gmail.com"]
  s.homepage    = "http://deploytracking.com"
  s.summary     = %q{Track deployments to deploytracking.com}
  s.description = %q{Keep a record of all your deployments with interesting stats and history of all deployments with capistrano}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
