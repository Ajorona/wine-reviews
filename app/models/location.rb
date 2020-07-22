class Location < ApplicationRecord
	has_one :parent, :class_name => 'Location', :foreign_key => 'parent_location'
end
