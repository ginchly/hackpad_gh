class ChangeSiteToSiteId < ActiveRecord::Migration
  def up
    rename_column :bookmarks, :site, :site_id
  end

  def down
  end
end
