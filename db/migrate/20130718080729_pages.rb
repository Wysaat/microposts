class Pages < ActiveRecord::Migration
  def up
    add_column :users, :pages, :integer
  end

  def down
  end
end
