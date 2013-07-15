class Useraddsth < ActiveRecord::Migration
  def up
    add_column :users, :topics_num, :integer
    add_column :users, :comments_num, :integer
  end

  def down
  end
end
