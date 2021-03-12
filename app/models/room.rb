class Room < ApplicationRecord
	has_many :members
	has_many :users, :through => :members

	after_commit :flush_cache
    

    #cached functions
    def self.cached_find_using_token(token)
        Rails.cache.fetch([name, token]) {
            find_by(token: token)
        }
    end

    def flush_cache
        Rails.cache.delete([self.class.name, token])
    end
end
