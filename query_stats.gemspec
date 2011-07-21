# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "query_stats/version"

Gem::Specification.new do |s|
  s.name        = "query_stats"
  s.version     = QueryStats::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Dan Manges"]
  s.summary     = "Track rails database queries."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '~>3.0'
  s.add_development_dependency 'rake'
end
