class ShortUrl < ApplicationRecord
  require 'uri'
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  validate :validate_full_url


  def short_code
    if full_url != nil
      self.to_base_62(id)
    end
  end

  def update_title!
  end

  def to_base_62(number)
    return "0" if number == 0
    result = ""
    while number > 0   
      r= number % 62 #get the position of the char of the CHARACTERS array 
      result.prepend(CHARACTERS[r]) #add the obtained char at the beginning of the result string
      number = (number/62).floor #get the integer part of the division and assign it to the number. 
      #Then repeat the process until the number be equal or less to 0
    end
    result 
  end

  def to_base_10(number)
    result=0
    digit=0
    number.split("").reverse.each do |char|
      index = BASE_62_VALUES.index(char)
      result += index * (62**digit)
      digit+=1
    end
    result
  end

  private
  
  #We parse the url and then use de URI library to validate
  #if it has HTTP or HTTPS format
  def validate_full_url
    uri = URI.parse(full_url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    errors.add(:full_url,'is not a valid url')
  end
end
