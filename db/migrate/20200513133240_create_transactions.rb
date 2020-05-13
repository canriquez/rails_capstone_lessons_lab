class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :teacher_id
      t.integer :enrolled_session_id
      t.integer :course_taught_id
      t.integer :status
      t.integer :minutes

      t.timestamps
      add_foreign_key :transactions, :enrolls, column: :enrolled_session_id, primary_key: "id"
      add_foreign_key :transactions, :groups, column: :course_taught_id, primary_key: "id"
    end
  end
end
