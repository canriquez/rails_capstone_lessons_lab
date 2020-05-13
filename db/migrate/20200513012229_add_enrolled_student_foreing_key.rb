class AddEnrolledStudentForeingKey < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :enrolled_student_id, :integer
    add_foreign_key :groups, :users, column: :enrolled_student_id, primary_key: "id"
  end
end