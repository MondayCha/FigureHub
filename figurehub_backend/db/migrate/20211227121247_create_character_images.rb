class CreateCharacterImages < ActiveRecord::Migration[5.2]
  def change
    create_table :character_images do |t|
      t.string :url
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
