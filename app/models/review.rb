class Review < ApplicationRecord
	has_one :wines
	has_one :taster

	STR_TO_MODEL = {
			'wine' => Wines,
			'winery' => Winery,
			'reviewer' => Taster,
			'variety' => Variety
	}.freeze

	def self.fetch_review_and_details(results, categories)
		detailed_results = []
		results.each do |result|
			detailed_result = {
					'review' => Review.find(result['id']),
					'wine' => STR_TO_MODEL['wine'].find('wine_id')
			}
			categories.each do |category|
				detailed_result[category] = STR_TO_MODEL[category].find(result["#{category}_id"])
			end
		end
		return detailed_results
	end
end
