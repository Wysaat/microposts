class ErrortaChecking < ActiveRecord::Migration
  def up
    remove_column :microposts, :dowvotes, :integer
    add_column :microposts, :downvotes, :integer
  end

  def down
  end
end
