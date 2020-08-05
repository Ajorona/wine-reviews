module Search
  class Reviews
    INDEX_NAME = "reviews"
    DEFAULT_PAGE = 0
    DEFAULT_PER_PAGE = 10

    class << self
      def search_documents(params:)
        set_query_size(params)
        results = search(body: Search::QueryBuilders::Reviews.new(params: params).get_query_hash)
        hits = results.dig("hits", "hits").map { |hit| prepare_doc(hit) }
        paginate_hits(hits, params)
      end

      private

      def search(body:)
        Search::Client.search(index: self::INDEX_NAME, body: body)
      end

      def paginate_hits(hits, params)
        start = params[:per_page] * params[:page]
        hits[start, params[:per_page]] || []
      end

      def prepare_doc(hit)
        hit.dig("_source")
      end

      def set_query_size(params)
        params[:page] ||= self::DEFAULT_PAGE
        params[:per_page] ||= self::DEFAULT_PER_PAGE
        params[:size] = params[:per_page].to_i * (params[:page].to_i + 1)
      end
    end
  end
end
