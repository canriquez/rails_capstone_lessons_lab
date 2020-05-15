class CreateEnrolls < ActiveRecord::Migration[5.2]
  def change
    create_table :enrolls do |t|
      t.integer :student_id
      t.integer :course_id
      add_foreign_key :enrolls, :users, column: :student_id, primary_key: "id"
      add_foreign_key :enrolls, :groups, column: :course_id, primary_key: "id"

      t.timestamps
    end
  end
end
