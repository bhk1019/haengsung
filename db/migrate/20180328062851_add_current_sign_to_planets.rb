class AddCurrentSignToPlanets < ActiveRecord::Migration[5.1]
  def change
    add_column :planets, :current_sign, :string
  end
end
