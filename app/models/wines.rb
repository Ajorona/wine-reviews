class Wines < ApplicationRecord
	has_one :winery
	has_one :variety
	has_one :designation
end
