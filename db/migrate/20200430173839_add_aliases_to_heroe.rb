class AddAliasesToHeroe < ActiveRecord::Migration[6.0]
  def change
    add_column :heroes, :aliases, :string
  end
end
