class CreateOrigins < ActiveRecord::Migration[5.2]
  def change
    create_table :origins do |t|
      t.string :name
      t.integer :kind
      t.text :info

      t.timestamps
    end
  end
end
