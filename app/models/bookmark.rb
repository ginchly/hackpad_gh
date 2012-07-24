class Bookmark < ActiveRecord::Base
  attr_accessible :full_url, :page_metadata, :page_title, :shortening, :site, :tags
  belongs_to :user
  validates :user_id, presence: true

  default_scope order: 'bookmarks.created_at DESC'
  #VALID_URL_REGEX = "^http\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(/\S*)?$"
  #validates :site, presence: true, format: { with: VALID_URL_REGEX }, uniqueness: { case_sensitive: false }
  
  
end
