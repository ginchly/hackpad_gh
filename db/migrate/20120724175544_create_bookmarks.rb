class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :full_url
      t.integer :user_id
      t.string :tags
      t.string :site
      t.string :shortening
      t.string :page_title
      t.string :page_metadata

      t.timestamps
    end
    add_index :bookmarks, [:user_id, :created_at]
  end
end
