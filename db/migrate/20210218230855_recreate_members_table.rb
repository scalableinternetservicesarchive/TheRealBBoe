class RecreateMembersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :room
      t.belongs_to :user
      t.boolean :is_host
      t.timestamps
    end
  end
end
