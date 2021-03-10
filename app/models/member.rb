class Member < ApplicationRecord
	belongs_to :room, touch: true
	belongs_to :user

	after_commit :flush_cache

	#cached functions
    def self.cached_find(user_id, room_id)
        Rails.cache.fetch([name, user_id, room_id]) {
            find_by(user_id: user_id, room_id: room_id)
        }
    end

    def self.cached_find_room_members(room_id)
        Rails.cache.fetch([name, room_id]) {
            where(room_id: room_id)
        }
    end

    def flush_cache
        Rails.cache.delete([self.class.name, user_id, room_id])
        Rails.cache.delete([self.class.name, room_id])
    end
end
