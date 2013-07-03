class GoodOrBad < ActiveRecord::Migration
  def up
  	add_column :users, :GoodOrBad, :boolean
  end

  def down
  end
end
