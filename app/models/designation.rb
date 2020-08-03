class Designation < ApplicationRecord
end
    add_reference :designations, :wineries, foreign_key: true
