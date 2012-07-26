# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :bookmarks, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    #find all bookmarks added by user
    Bookmark.find(:all, :joins => :sites, :include => :sites, :conditions => ["user_id = ?", id], order: "bookmarks.created_at DESC")
  end

  def sites_feed
    #get all bookmarks added by user, ordered by site_host so can group on page and allow user to click
    #to show/hide bookmarks belonging to a particular site
    Bookmark.find(:all, :joins => :sites, :include => :sites, :conditions => ["user_id = ?", id], :order => "sites.site_host")
  end

  def site_bookmarks(site_id)
    #find bookmarks that belong to site and have been added by current user
    Bookmark.find(:all, :joins => :sites, :include => :sites, :conditions => ["sites.id = ? and user_id = ?", site_id, id])
  end
  
  private
    #use remember token to maintaining users signin status
    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
    end

end
