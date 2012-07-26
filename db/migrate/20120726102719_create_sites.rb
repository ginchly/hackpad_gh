class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site_host

      t.timestamps
    end
    add_index :sites, [:site_host]
  end
end
