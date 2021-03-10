class User < ApplicationRecord
	has_many :members
	has_many :rooms, :through => :members

	after_commit :flush_cache
    
    # cached functions
    def self.cached_find(id)
        Rails.cache.fetch([name, id]) {
            find(id)
        }
    end

    def flush_cache
        Rails.cache.delete([self.class.name, id])
    end
end
