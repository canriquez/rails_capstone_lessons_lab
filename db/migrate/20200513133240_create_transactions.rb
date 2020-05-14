class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :teacher_id
      t.integer :enrolled_session_id
      t.integer :course_taught_id
      t.integer :status
      t.integer :minutes
      t.date    :accdate

      t.timestamps
    end
  end
end
