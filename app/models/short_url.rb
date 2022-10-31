class ShortUrl < ApplicationRecord
  require 'uri'
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  validate :validate_full_url


  def short_code
  end

  def update_title!
  end


  private

  def validate_full_url
    uri = URI.parse(full_url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    errors.add(:full_url,'Invalid_url')
  end
end
