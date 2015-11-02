class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index :questions, [:user_id, :created_at]
    add_index :questions, :title, unique: true
  end
end
