class Api::V1::UrlsController < Api::V1::ApplicationController
  before_action :set_url, only: [:destroy]
  include UrlsHelper

  #> -----------------------------------------------------------------------
  #> GET /api/v1/urls
  #> -----------------------------------------------------------------------
  #> PARAMETER
  #>RETURNS:
  #>  {
  #>   'status'  => '200',
  #>    items: [
  #
  #>      ]
  #>   }
  def index
    json_object = {}
    @urls = Url.all.order("pageviews DESC")
    json_object[:items] = @urls
    json_object[:status] = :ok

    render json: json_object, each_serializer: Api::V1::UrlsSerializer
  end

  #> -----------------------------------------------------------------------
  #> GET /api/v1/urls/short_urls
  #> -----------------------------------------------------------------------
  #> PARAMETER
  #>RETURNS:
  #>  {
  #>   'status'  => '200',
  #>    items: [
  #
  #>      ]
  #>   }
  def short_urls
    json_object = {}
    @urls = Url.all.order("pageviews DESC")
    short_url = Url.all.order("pageviews DESC").pluck(:short_url).reject(&:empty?).map{|i| "#{request.host_with_port}/#{i}"}
    json_object[:items] = short_url
    json_object[:status] = :ok

    render json: json_object, each_serializer: Api::V1::UrlsSerializer
  end

  #> -----------------------------------------------------------------------
  #> POST /api/urls/
  #> -----------------------------------------------------------------------
  #>
  #> PARAMETERS:
  #> - original_url: string  : mandatory

  #> RETURNS:
  #> {
  #>   'status'  => '200'
  #> }
  def create
    json_object = {}
    if params[:original_url].present?
      @url = Url.new
      @url = Url.create_update_with(params)
      @short_url = "#{request.host_with_port}/#{@url.short_url}"
      json_object[:status] = :ok
      render json: json_object, each_serializer: Api::V1::UrlsSerializer
    else
      json_object[:status] = :bad_request
      render json: json_object, each_serializer: Api::V1::UrlsSerializer
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

  #> -----------------------------------------------------------------------
  #> delete /api/urls
  #> -----------------------------------------------------------------------
  #> PARAMETERS:
  #> - id: integer  : mandatory

  #> RETURNS:
  #> {
  #>   'status'  => '200'
  #> }
  def destroy
    @url.destroy
    json_object={}
    json_object[:status] = :ok
    render json: json_object, each_serializer: Api::V1::UrlsSerializer
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_url
    @url = Url.find(params[:id])
  end

end
