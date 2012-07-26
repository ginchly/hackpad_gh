class Sites < ActiveRecord::Base
  attr_accessible :site_host
  has_many :bookmarks


end
