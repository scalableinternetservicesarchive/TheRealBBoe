class Member < ApplicationRecord
    scope :all_users_in_room, -> (room_id) { where(room: room_id) }

	belongs_to :room
	belongs_to :user
end
