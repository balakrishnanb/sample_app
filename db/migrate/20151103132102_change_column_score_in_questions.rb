class ChangeColumnScoreInQuestions < ActiveRecord::Migration
  def change
    change_column :questions, :score, :integer, default: 0
  end
end
