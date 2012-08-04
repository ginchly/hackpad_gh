class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_no, :string
    add_column :users, :photo_url, :string
    add_column :users, :skills, :string
    add_column :users, :status, :string
  end
end
