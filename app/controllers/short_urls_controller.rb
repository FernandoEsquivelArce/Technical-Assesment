class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @urls= [] 
    ShortUrl.select(:full_url).order(click_count: :desc).limit(100).each do |url|
      @urls.append(url["full_url"])
    end
    if @urls != nil
      render json: {urls:@urls , status:200}
    end
  end

  def create
    @url = ShortUrl.new(full_url:params[:full_url])
    if @url.save 
      print(@url.errors)
      render json: {short_code:@url.short_code,status:200}
    else
      print(@url.errors)
      render json: errors:@url.errors
    end
  end

  def show
  end

end
