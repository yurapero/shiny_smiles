class Favorite < ApplicationRecord
    belongs_to :customer
    belongs_to :review
    belongs_to :submission
end