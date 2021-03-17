class AddIndexToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :token, :string
    add_index :rooms, :token
  end
end
