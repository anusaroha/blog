class CreateComments < ActiveRecord::Migration
  if table_exists? :table_name
              remove_table :table_name
      end

  def change
    create_table :comments do |t|
      t.string :commenters
      t.text :body
      t.references :article, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
