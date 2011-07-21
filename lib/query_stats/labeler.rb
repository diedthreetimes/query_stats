module QueryStats
  # Automatically labels queries as to whether they were executed
  # in the controller or in the view.
  module Labeler
    def self.included(base)
      base.class_eval do
        alias_method_chain :render, :query_stats
      end
    end

    ActiveSupport::Notifications.subscribe /start_processing.action_controller/ do
      ActiveRecord::Base.connection.queries.clear
      ActiveRecord::Base.connection.queries.label = :controller
    end

    protected

    def render_with_query_stats(*args, &block)
      queries.label = :view
      render_without_query_stats(*args, &block)
    end

    def queries
      ActiveRecord::Base.connection.queries
    end
  end
end
