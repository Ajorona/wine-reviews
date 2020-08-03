class SearchableReview
	include ActiveModel::Model
	attr_accessor :id, :wine, :wine_id, :winery, :winery_id, :reviewer, :reviewer_id, :variety, :variety_id
end
