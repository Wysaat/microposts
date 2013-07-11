class UserAddAttrs < ActiveRecord::Migration
  def up
    add_column :users, :followers_num, :integer
    add_column :users, :followings_num, :integer
  end

  def down
  end
end
