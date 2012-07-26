class CorrectColumNameSites < ActiveRecord::Migration
  def up
        rename_column :bookmarks, :site_id, :sites_id
  end

  def down
  end
end
