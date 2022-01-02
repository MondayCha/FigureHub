class CreateFigureCharacterAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :figure_character_associations do |t|
      t.references :figure, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
