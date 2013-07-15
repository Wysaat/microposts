class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :content
      t.integer :owner_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
