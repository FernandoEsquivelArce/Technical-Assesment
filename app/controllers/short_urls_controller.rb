class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @urls=ShortUrl.all 
  end

  def create
    
    @url = ShortUrl.new(full_url:params[:full_url])
    print(@url.valid?)
    if @url.save 
      render json: @url,status:200
    else
      render json: {error:@url.errors}
    end
  end

  def show
  end

end
