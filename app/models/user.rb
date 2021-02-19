class User < ApplicationRecord
	has_many :members
	has_many :rooms, :through => :members
end
