class Room < ApplicationRecord
	has_many :members
	has_many :users, :through => :members
	belongs_to :user, foreign_key: :host_id, class_name: 'User'
end
