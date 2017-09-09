class Url < ActiveRecord::Base
  validates_uniqueness_of :original_url
  after_create :add_short_url_to_url
  after_commit :update_pageviews

  def add_short_url_to_url
    # Generate the epoch token to identify uniquely
    # Base36 initializer
    self.update_columns( short_url: Base36.encode(Time.now.to_i) )
  end

  # update total number of pageviews for a particuler URL
  def update_pageviews
    self.update_columns( pageviews: self.pageviews+1)
  end

  def self.create_update_with(params)
    dup = Url.duplicate(params)
    if dup.present?
      url= dup.update(params)
    else
      url = Url.create(params)
    end
    return url
  end

  #Overwrite the create method
  def self.create(params)
    puts params[:original_url]
    url = Url.new
    retry_count = 2
    begin
      #if
      if params[:original_url].blank?
        raise ArgumentError.new("original_url is a required field")
      end

      url.original_url = params[:original_url]
      url.short_url = params[:short_url] if  params[:short_url].present?
      url.pageviews = params[:pageviews] if  params[:pageviews].present?
      url.save
      return url

    rescue ActiveRecord::RecordNotUnique => e
      puts "DEBUG>> caught record not unique exception while making URL: #{e.message}"
      retry_count -= 1
      retry if retry_count > 0
      puts "DEBUG>> error while creating URL: #{e.message}"
      return nil
    end
  end

  #overwrite the update method
  def update(params)
    self.original_url = params[:original_url] if params[:original_url].present?
    self.short_url = params[:short_url] if params[:short_url].present?
    self.pageviews = params[:pageviews] if params[:pageviews].present?
    self.save
    return self
  end

  # Check the duplicate original_url in the database
  # If the original_url is present then return the mathing url objects
  # otherwise it returns the nil object
  def self.duplicate(params)
    Url.where("original_url =?", params[:original_url]).take
  end

  
end
