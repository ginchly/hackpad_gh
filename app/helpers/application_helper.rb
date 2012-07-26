module ApplicationHelper
    def shorten_with_bitly(url)
        # build url to bitly api
        user = "o_2jdud4fj1n"
        apikey = "R_543ba0e1656287a68dbba950f0f22b13"
        version = "2.0.1"
        bitly_url = "http://api.bit.ly/shorten?version=#{version}&longUrl=#{url}&login=#{user}&apiKey=#{apikey}"
         
        # parse result and return shortened url
        buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
        result = JSON.parse(buffer)
        short_url = result['results'][url]['shortUrl']
    end
end
