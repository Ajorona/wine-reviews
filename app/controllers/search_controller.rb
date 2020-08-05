class SearchController < ApplicationController
	DEFAULT_PAGE = 0
	DEFAULT_PER_PAGE = 10

	def default_review_search
		options = {query: params[:query], size: DEFAULT_PER_PAGE, per_page: DEFAULT_PER_PAGE}
		reviews = Search::Reviews.search_documents(params: options)
		render json: {results: reviews}
	end

	def reviews_by_wine
		search_by_category("wine", params[:query])
	end

	def reviews_by_variety
		search_by_category("variety", params[:query])
	end

	def reviews_by_taster
		search_by_category("reviewer", params[:query])
	end

	def reviews_by_winery
		search_by_category("winery", params[:query])
	end

	private

	def search_by_category(category, query)
		options = {category: category,  query: query, size: DEFAULT_PER_PAGE, per_page: DEFAULT_PER_PAGE}
		reviews = Search::Review.search_documents(params: options)
		render json: {results: reviews}
	end
end