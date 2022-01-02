class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.references :merchandise, foreign_key: true
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
