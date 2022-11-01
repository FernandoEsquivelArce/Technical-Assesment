class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    @url=ShortUrl.find_by_id(short_url_id) 
    @url.update_title!
  end
end
