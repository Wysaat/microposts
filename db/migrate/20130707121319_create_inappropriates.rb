class CreateInappropriates < ActiveRecord::Migration
  def change
    create_table :inappropriates do |t|
      t.integer :inappropriate_voter_id
      t.integer :inappropriate_voted_id

      t.timestamps
    end
  end
end
