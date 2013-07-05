class AddAttrToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :upvotes, :integer
    add_column :microposts, :downvotes, :integer
    add_column :microposts, :inappropriate, :integer
  end
end
