class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :user
      t.references :question
      t.timestamps
    end
  end
end
