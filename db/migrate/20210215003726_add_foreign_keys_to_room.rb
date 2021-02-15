class AddForeignKeysToRoom < ActiveRecord::Migration[6.1]
  def change	
    add_reference :rooms, :host, index: false
    add_reference :rooms, :location, index: false
  end
end
