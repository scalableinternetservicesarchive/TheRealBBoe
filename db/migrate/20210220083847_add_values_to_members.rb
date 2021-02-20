class AddValuesToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :participated, :boolean
    add_column :members, :selections, :integer, array: true, default: '{}' 
  end
end
