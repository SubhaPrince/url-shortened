class UrlsController < ApplicationController
  include UrlsHelper
  # GET /urls/new
  def new
    @url = Url.new
  end

  #<summary>
  #This method stores actual URL in database
  # </summary>
  # <param name="url_params">The actual URL</param>
  # <returns>Corresponding shorten URL</returns>
  def create
    @url = Url.create_update_with(url_params)
    @short_url = "#{request.host_with_port}/#{@url.short_url}"
    redirect_to root_path(short_url: @short_url)
  end

  def redirect
    # this method returns external URL
    shortened_url = Url.find_by_short_url(params[:short_url])

    # generate_url is a helper method which will helps to format the URL
    redirect_to generate_url(shortened_url.original_url)
  end



  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def url_params
    params.require(:url).permit(:original_url, :short_url)
  end
end
