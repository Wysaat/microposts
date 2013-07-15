class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string  :title
      t.string  :content
      t.integer :owner_id
      t.integer :forum_id
      t.integer :comments_num

      t.timestamps
    end
  end
end
