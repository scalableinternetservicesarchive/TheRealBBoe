class User < ApplicationRecord
	has_many :members
	has_many :rooms, :through => :members

	after_commit :flush_cache
    
    # cached functions
    def self.cached_find(id)
        Rails.cache.fetch([name, "id", id]) {
            find(id)
        }
    end

    def self.cached_find_username(username)
        Rails.cache.fetch([name, "username", username]) {
            find_by(username: username)
        }
    end

    def self.cached_find_username_password(username, password)
        Rails.cache.fetch([name, "userpass", username, password]) {
            find_by(username: username, password: password)
        }
    end

    def flush_cache
        Rails.cache.delete([self.class.name, "id", id])
        Rails.cache.delete([self.class.name, "username", username])
        Rails.cache.delete([self.class.name, "userpass", username])
    end
end
