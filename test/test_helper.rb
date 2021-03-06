$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'test/unit'
require 'rubygems'
gem "rails", ENV["RAILS_VERSION"] || "1.2.6"
require "rails/version"
require 'active_record'
require 'active_record/fixtures'
require 'action_controller'
require 'action_controller/test_process'

ActiveRecord::Base.configurations['test'] = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'][ENV['DB'] || 'sqlite3'])

if Rails::VERSION::MAJOR == 1
  (class << ActiveRecord::Base.connection; self; end).class_eval do
    def clear_query_cache; end
  end
end


require 'query_stats/helper'
require 'query_stats'
require 'query_stats/holder'
require 'query_stats/labeler'
require 'query_stats/logger'
require 'query_stats/recorder'

require "#{File.dirname(__FILE__)}/../init"
# make sure multiple requires don't create stack level too deep error
load "#{File.dirname(__FILE__)}/../init.rb"

load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

class Test::Unit::TestCase #:nodoc:
  def create_fixtures(*table_names)
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
  end

  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...
end

class Person < ActiveRecord::Base
end
