class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :gender
      t.text :info
      t.references :origin, foreign_key: true

      t.timestamps
    end
  end
end
