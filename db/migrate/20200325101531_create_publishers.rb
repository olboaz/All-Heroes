class CreatePublishers < ActiveRecord::Migration[6.0]
  def change
    create_table :publishers do |t|
      t.string :name
      t.references :heroe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
