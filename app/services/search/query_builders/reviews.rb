module Search
  module QueryBuilders
    class Reviews
      attr_accessor :params, :body

      DEFAULT_PARAMS = {
          size: 0
      }.freeze

      def get_query_hash
        @body
      end

      def initialize(params:)
        @params = params.deep_symbolize_keys
        build_body
      end

      def build_body
        @body = ActiveSupport::HashWithIndifferentAccess.new
        build_queries
        set_size
      end

      def build_queries
        if @params[:category]
          @body[:query] = {
            multi_match: {
              query: @params[:query] ? @params[:query] : "",
              type: "cross_fields",
              fields: %W[#{@params[:category]}^2 #{@params[:category]}.ngram]
            }
          }
        else
          @body[:query] = {
            multi_match: {
              query: @params[:query] ? @params[:query] : "",
              type: "cross_fields",
              fields: %w[wine wine.ngram winery winery.ngram reviewer reviewer.ngram variety variety.ngram]
            }
          }
        end
      end

      def set_size
        @body[:size] = @params[:size] || self.class::DEFAULT_PARAMS[:size]
      end
    end
  end
end