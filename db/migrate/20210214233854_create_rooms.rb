class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :token
      t.string :name

      t.timestamps
    end
  end
end
