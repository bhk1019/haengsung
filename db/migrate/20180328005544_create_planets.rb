class CreatePlanets < ActiveRecord::Migration[5.1]
  def change
    create_table :planets do |t|
      t.string :name
      t.string :description
      t.integer :swe_id
      t.timestamps
    end
  end
end
