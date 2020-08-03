module Search
	class SearchableReviewSerializer
		include FastJsonapi::ObjectSerializer
		attributes :id, :wine, :wine_id, :winery, :winery_id, :reviewer, :reviewer_id, :variety, :variety_id
end
