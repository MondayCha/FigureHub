class CreateDealComments < ActiveRecord::Migration[5.2]
  def change
    create_table :deal_comments do |t|
      t.references :deal, foreign_key: true
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
