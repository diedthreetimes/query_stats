module QueryStats
  module Headers
    protected

    # This is in the api docs but i don't know where the info is spit out.
    def append_info_to_payload payload
      super
      payload[:query_count] = ActiveRecord::Base.connection.queries.count.to_s
      payload[:query_runtime] = "%.5f" % ActiveRecord::Base.connection.queries.runtime.to_s
    end

  end
end
