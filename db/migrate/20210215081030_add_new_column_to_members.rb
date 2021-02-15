class AddNewColumnToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :is_host, :boolean
  end
end
