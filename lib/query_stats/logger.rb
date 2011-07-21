module QueryStats
  module Logger
    def self.included(base)
      base.class_eval do
        alias_method_chain :debug, :query_stats
      end
    end

    protected

    def debug_with_query_stats(*args, &block)
      args.push( " #{ActiveRecord::Base.connection.queries.count} queries" )
      debug_without_query_stats(*args, &block)
    end
  end
end
