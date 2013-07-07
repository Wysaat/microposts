class CreateDownvotes < ActiveRecord::Migration
  def change
    create_table :downvotes do |t|
      t.integer :downvoter_id
      t.integer :downvoted_id

      t.timestamps
    end
  end
end
