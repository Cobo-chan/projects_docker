class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.text :title,             null: false
      t.integer :genre_id,       null: false
      t.integer :country_id,     null: false
      t.text :text,              null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
