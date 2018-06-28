class AddIsRetrogradeToPlanet < ActiveRecord::Migration[5.1]
  def change
    add_column :planets, :is_retrograde, :boolean
  end
end
