class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :merchandise, foreign_key: true
      t.references :figure, foreign_key: true

      t.timestamps
    end
  end
end
