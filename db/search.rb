

BATCH_SIZE = 1000
start = 0
finish = start + BATCH_SIZE

loop do
	review_batch = Review
		.joins("INNER JOIN wines ON reviews.wines_id = wines.id")
		.joins("LEFT JOIN tasters ON reviews.tasters_id = tasters.id")
		.joins("LEFT JOIN wineries ON wines.wineries_id = wineries.id")
		.joins("LEFT JOIN varieties ON wines.varieties_id = varieties.id")
		.where("reviews.id BETWEEN ? AND ?", start, finish)
        .select(
					'reviews.id as review_id,
        	 wines.id as wine_id, wines.name as wine,
        	 tasters.id as taster_id, tasters.name as taster_name,
        	 wineries.id as winery_id, wineries.name as winery,
        	 varieties.id as variety_id, varieties.name as variety'
    	)

    review_batch.each do |record|
    	searchable_review = SearchableReview.new
    	searchable_review.id = record.review_id
    	searchable_review.wine = record.wine
    	searchable_review.wine_id = record.wine_id
    	searchable_review.winery = record.winery
    	searchable_review.winery_id = record.winery_id
    	searchable_review.reviewer = record.taster_name
    	searchable_review.reviewer_id = record.taster_id
    	searchable_review.variety = record.variety
    	searchable_review.variety_id = record.variety_id

		serialized_data = Search::SearchableReviewSerializer.new(searchable_review).serializable_hash.dig(:data, :attributes)
		SearchClient.index(id: searchable_review.id, index: "reviews", body: serialized_data)
		start += 1
    end
	break if review_batch.length < BATCH_SIZE
	start = finish
	finish = start + BATCH_SIZE
end

	
