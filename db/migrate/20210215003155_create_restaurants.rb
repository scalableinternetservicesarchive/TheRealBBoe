class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.belongs_to :location, index: true, foreign_key: true

      t.timestamps
    end
  end
end
