class AddGenderToHeroe < ActiveRecord::Migration[6.0]
  def change
    add_column :heroes, :gender, :string
    add_column :heroes, :race, :string
  end
end
