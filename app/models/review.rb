class Review < ApplicationRecord
	has_one :wines
	has_one :taster
end
