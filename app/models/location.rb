class Location < ApplicationRecord
	has_many :restaurants
	has_many :rooms
end
