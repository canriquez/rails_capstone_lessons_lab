class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :teacher_id
      t.integer :status
      t.integer :minutes
      t.date    :accdate

      t.timestamps
    end
    t.integer :sitting_student_id, null: true, foreign_key: true
    t.integer :course_taught_id, null: true, foreign_key: true
  end
end
