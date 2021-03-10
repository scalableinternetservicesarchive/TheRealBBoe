class Restaurant < ApplicationRecord
	belongs_to :location

	after_commit :flush_cache
    
    # cached functions
    def self.cached_restaurants_in_location(location_id)
        Rails.cache.fetch([name, location_id]) {
            where(location_id: location_id)
        }
    end

    def flush_cache
        Rails.cache.delete([self.class.name, id])
    end
end
