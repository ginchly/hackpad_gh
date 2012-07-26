class ChangeSiteIdTypeInBookmarks < ActiveRecord::Migration
  def up
    remove_column :bookmarks, :site_id
    add_column :bookmarks, :site_id, :integer
  end

  def down
  end
end
