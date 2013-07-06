class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :upvoter_id
      t.integer :upvoted_id

      t.timestamps
    end
  end
end
