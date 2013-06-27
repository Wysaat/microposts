class EditRelations < ActiveRecord::Migration
  def up
  	add_column :relations, :follower, :string
  	add_column :relations, :followee, :string
  end

  def down
  end
end
