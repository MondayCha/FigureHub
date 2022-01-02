class CreateFigureComments < ActiveRecord::Migration[5.2]
  def change
    create_table :figure_comments do |t|
      t.references :figure, foreign_key: true
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
