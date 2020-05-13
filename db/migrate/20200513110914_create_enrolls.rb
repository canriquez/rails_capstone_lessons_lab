class CreateEnrolls < ActiveRecord::Migration[5.2]
  def change
    create_table :enrolls do |t|
      t.integer :enrolled_student_id
      t.integer :course_enrolled_id
      add_foreign_key :enrolls, :users, column: :enrolled_student_id, primary_key: "id"
      add_foreign_key :enrolls, :ugroups, column: :course_enrolled_id, primary_key: "id"

      t.timestamps
    end
  end
end
