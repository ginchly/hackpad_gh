class Bookmark < ActiveRecord::Base
  attr_accessible :full_url, :page_metadata, :page_title, :shortening, :sites_id, :tags
  belongs_to :user
  belongs_to :sites

  before_save :add_url_protocol, :parse_url, :get_metadata, :shorten_url

  VALID_URL_REGEX = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  validates :full_url, presence: true, uniqueness: { case_sensitive: false } #format: { with: VALID_URL_REGEX }

  default_scope order: 'bookmarks.created_at DESC'

  private
    #get site from full url, add http:// if doesnt already exist
    def add_url_protocol
      unless self.full_url[/^https?:\/\//]
        self.full_url = 'http://' + self.full_url
      end
    end

    #use built in ruby functionality to get site host so can collect by site
    def parse_url
        uri = URI.parse(self.full_url)
        site_host = Sites.find_or_create_by_site_host(uri.host)
        self.sites_id = site_host.id.to_i
    end

    #shorten using bitly gem
    def shorten_url
        username = "o_2jdud4fj1n"
        apikey = "R_543ba0e1656287a68dbba950f0f22b13"

        # Use api version 3 or get a deprecation warning
        Bitly.use_api_version_3

        bitly = Bitly.new(username, apikey)
        self.shortening = bitly.shorten(self.full_url).short_url
    end

    #get bookmark title and description using pismo gem
    def get_metadata
        doc = Pismo::Document.new(self.full_url)
        #use titles instead of title due to webpages using multiple titles for SEO
        #use join so displays multiple titles nicely
        page_titles = doc.titles
        page_titles = page_titles.join(" - ")
        self.page_title = page_titles
        self.page_metadata = doc.description
    end
  
end
