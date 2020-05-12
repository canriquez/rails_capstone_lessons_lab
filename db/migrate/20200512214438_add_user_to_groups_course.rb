class AddUserToGroupsCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :author_id, :integer
    add_foreign_key :groups, :users, column: :author_id, primary_key: "id"
  end
end
