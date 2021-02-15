class User < ApplicationRecord
	has_many :members
	has_many :rooms, :through => :members
	has_many :rooms, foreign_key: :host_id, class_name: "Room", dependent: :nullify
end
