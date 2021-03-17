class RemoveTokenFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :token, :string
  end
end
