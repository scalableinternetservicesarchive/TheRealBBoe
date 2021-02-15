class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :rooms
      t.belongs_to :users
      t.timestamps
    end
  end
end
