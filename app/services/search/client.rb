module Search
  # Search client (uses Elasticsearch as a backend)
  class Client
    class << self
      # adapted from https://api.rubyonrails.org/classes/Module.html#method-i-delegate_missing_to
      def method_missing(method, *args, &block)
        return super unless target.respond_to?(method, false)

        # define for re-use
        self.class.define_method(method) do |*new_args, &new_block|
          request do
            target.public_send(method, *new_args, &new_block)
          end
        end

        # call the original method, this will only be called the first time
        # as in subsequent calls, the newly defined method will prevail
        request do
          target.public_send(method, *args, &block)
        end
      end

      # adapted from https://api.rubyonrails.org/classes/Module.html#method-i-delegate_missing_to
      def respond_to_missing?(method, _include_all = false)
        target.respond_to?(method, false) || super
      end

      private

      def request
        yield
      rescue
        # TODO: ADD ERROR HANDLING
      end

      def target
        @target ||= Elasticsearch::Client.new(
            url: 'http://localhost:9200',
            retry_on_failure: 5,
            request_timeout: 30,
            adapter: :typhoeus,
            log: Rails.env.development?,
            )
      end
    end
  end
end