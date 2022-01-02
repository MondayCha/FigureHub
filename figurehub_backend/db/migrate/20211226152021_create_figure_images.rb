class CreateFigureImages < ActiveRecord::Migration[5.2]
  def change
    create_table :figure_images do |t|
      t.string :url
      t.references :figure, foreign_key: true

      t.timestamps
    end
  end
end
