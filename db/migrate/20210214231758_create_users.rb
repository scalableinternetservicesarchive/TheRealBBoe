class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.boolean :is_auth
      t.string :username
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
