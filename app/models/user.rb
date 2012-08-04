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
  attr_accessible :email, :name, :password, :password_confirmation, :phone_no, :skills, :status
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  

  def site_bookmarks(site_id)
    #find bookmarks that belong to site and have been added by current user
    Bookmark.find(:all, :joins => :sites, :include => :sites, \
     :conditions => ["sites.id = ? and user_id = ?", site_id, id], order: "bookmarks.created_at DESC")
  end
  
  private
    #use remember token to maintaining users signin status
    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
    end

end
