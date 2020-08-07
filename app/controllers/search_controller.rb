class SearchController < ApplicationController
	DEFAULT_PAGE = 0
	DEFAULT_PER_PAGE = 10


	def default_review_search
		options = {query: params[:query], size: DEFAULT_PER_PAGE, per_page: DEFAULT_PER_PAGE}
		search_results = Search::Reviews.search_documents(params: options)
		@detailed_results = Review.fetch_review_and_details(search_results, %w[wine winery reviewer variety])
		render 'index.json.jbuilder'
	end

	def reviews_by_wine
		default_review_search
	end

	def reviews_by_variety
		@detailed_results = fetch_detailed_results(params, "variety")
		render 'index.json.jbuilder'
	end

	def reviews_by_taster
		@detailed_results = fetch_detailed_results(params, "taster")
		render 'index.json.jbuilder'
	end

	def reviews_by_winery
		@detailed_results = fetch_detailed_results(params, "winery")
		render 'index.json.jbuilder'
	end

	private

  def fetch_detailed_results(params, category)
		options = {category: category,  query: params[:query], size: DEFAULT_PER_PAGE, per_page: DEFAULT_PER_PAGE}
		search_results = Search::Reviews.search_documents(params: options)
		Review.fetch_review_and_details(search_results, category)
	end
end