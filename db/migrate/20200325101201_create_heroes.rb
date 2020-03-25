class CreateHeroes < ActiveRecord::Migration[6.0]
  def change
    create_table :heroes do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :image_hero
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
