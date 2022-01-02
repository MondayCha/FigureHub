class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.integer :kind
      t.string :avatar
      t.string :password_digest

      t.timestamps
    end
  end
end
