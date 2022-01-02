class CreateFigures < ActiveRecord::Migration[5.2]
  def change
    create_table :figures do |t|
      t.string :name
      t.integer :kind
      t.decimal :price
      t.string :scale
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
