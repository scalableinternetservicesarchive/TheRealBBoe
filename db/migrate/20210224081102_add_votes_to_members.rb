class AddVotesToMembers < ActiveRecord::Migration[6.1]
  def change
  	add_column :members, :votes, :string
  end
end
