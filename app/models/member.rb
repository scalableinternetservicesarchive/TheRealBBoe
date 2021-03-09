class Member < ApplicationRecord
	belongs_to :room, touch: true
	belongs_to :user
end
