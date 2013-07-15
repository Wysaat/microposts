class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string  :name
      t.integer :topics_num

      t.timestamps
    end
  end
end
