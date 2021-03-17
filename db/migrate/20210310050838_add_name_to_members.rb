class AddNameToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :name, :string
  end
end
