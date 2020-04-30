class AddPowerstatsToHeroe < ActiveRecord::Migration[6.0]
  def change
    add_column :heroes, :intelligence, :integer
    add_column :heroes, :strength, :integer
    add_column :heroes, :speed, :integer
    add_column :heroes, :durability, :integer
    add_column :heroes, :power, :integer
    add_column :heroes, :combat, :integer
  end
end
