module UrlsHelper
  def generate_url(url, params = {})
    # the way  to ensure rails recognises the link as external. 
    # without protocal, rails assumes that the link is internal
    /^http/.match(url) ? url : "http://#{url}"
  end
end
