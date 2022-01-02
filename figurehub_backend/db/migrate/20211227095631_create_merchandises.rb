class CreateMerchandises < ActiveRecord::Migration[5.2]
  def change
    create_table :merchandises do |t|
      t.decimal :price
      t.integer :status
      t.integer :kind
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
