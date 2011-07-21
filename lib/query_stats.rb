require 'benchmark'
require 'query_stats/version'
require 'query_stats/recorder'
require 'query_stats/labeler'
require 'query_stats/logger'
require 'query_stats/headers'
require 'query_stats/helper'

module QueryStats
end

Rails::Application.initializer("query_stats") do
  ActiveRecord::Base.connection.class.send :include, QueryStats::Recorder
  ActionController::Base.send :include, QueryStats::Labeler
  ActionController::Base.send :include, QueryStats::Headers
  #ActiveRecord::LogSubscriber.send :include, QueryStats::Logger
  ActionController::Base.helper QueryStats::Helper
end


