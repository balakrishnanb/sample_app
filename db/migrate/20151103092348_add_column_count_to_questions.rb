class AddColumnCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :upvotes_count, :integer
  end
end
