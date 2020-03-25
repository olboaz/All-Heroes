class AddCoordinatesToHeroes < ActiveRecord::Migration[6.0]
  def change
    add_column :heroes, :latitude, :float
    add_column :heroes, :longitude, :float
  end
end
