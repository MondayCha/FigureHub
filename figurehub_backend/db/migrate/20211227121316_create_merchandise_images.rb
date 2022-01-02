class CreateMerchandiseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :merchandise_images do |t|
      t.string :url
      t.references :merchandise, foreign_key: true

      t.timestamps
    end
  end
end
