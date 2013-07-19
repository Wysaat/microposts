class CreatePcomments < ActiveRecord::Migration
  def change
    create_table :pcomments do |t|
      t.integer :good
      t.integer :bad

      t.timestamps
    end
  end
end
