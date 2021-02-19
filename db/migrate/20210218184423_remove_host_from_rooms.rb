class RemoveHostFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :host_id, :bigint
  end
end
