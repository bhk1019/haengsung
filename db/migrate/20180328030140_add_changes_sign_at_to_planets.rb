class AddChangesSignAtToPlanets < ActiveRecord::Migration[5.1]
  def change
    add_column :planets, :changes_sign_at, :datetime
  end
end
