class UrlsController < ApplicationController
  before_action :set_url, only: [:destroy]
  include UrlsHelper
  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all.order("pageviews DESC").limit(100)
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # => <summary>
  # =>  This method stores actual URL in database
  # => </summary>
  # => <param name="file"> CSV file </param>
  # => <param name="url_params">The actual URL</param>
  # => <returns>Corresponding shorten URL</returns>
  def create
    if url_params[:file].present?
      puts url_params[:file]
      Url.import(url_params[:file])
      redirect_to root_path, notice: 'Successfully uploaded'
    elsif url_params[:original_url].present?

      @url = Url.create_update_with(url_params)
      @short_url = "#{request.host_with_port}/#{@url.short_url}"
      redirect_to root_path(short_url: @short_url)
    else
      redirect_to root_path, alert: 'Please enter the URL in the text box or choose the csv file'
    end

  end

  def redirect
    # this method returns external URL and Update the page views
    shortened_url = Url.find_by_short_url(params[:short_url])
    # update page view
    shortened_url.update_pageviews
    # generate_url is a helper method which will helps to format the URL
    redirect_to generate_url(shortened_url.original_url)
  end

  # DELETE /url/1
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_url
    @url = Url.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def url_params
    params.require(:url).permit(:original_url, :short_url, :file)
  end
end
