class RenameUpvotesCountToScoreInQuestions < ActiveRecord::Migration
  def up
    rename_column :questions, :upvotes_count, :score
  end

  def down
    rename_column :questions, :score, :upvotes_count
  end
end
