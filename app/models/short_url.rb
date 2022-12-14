class ShortUrl < ApplicationRecord
  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  validate :validate_full_url

  def short_code
    if full_url != nil
      self.to_base_62(id)
    end
  end

  def public_attributes
    self.full_url
  end 

  #find by short_code
  #converte to Base10 the received code
  def self.find_by_short_code(code)
    self.find(to_base_10(code))
  end

  #get the title from given url, by match the obtained html with the regualr expresion of title tag
  def update_title!
    uri = URI(self.full_url)
    html= Net::HTTP.get(uri)
    regexp = /<title>(.*)<\/title>/
    regexp.match(html)
    self.update(title:$1.to_s)
  end

  #
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

  #do the reverse process of de base_62 codification
  def self.to_base_10(code)
    result=0
    digit=0
    code.split("").reverse.each do |char| 
      index = CHARACTERS.index(char)
      result += index * (62**digit)
      digit+=1
    end
    result
  end

  private
  
  #We parse the url and then use de URI library to validate
  #if it is valid and has HTTP or HTTPS format 
  def validate_full_url
    if full_url == nil || full_url.strip==""
      errors.add(:full_url,:blank)
      return
    end 
    uri = URI.parse(full_url)
    if !uri.is_a?(URI::HTTP) || !uri.is_a?(URI::HTTPS)
      errors.add(:full_url,"is not a valid url")
    end
  rescue URI::InvalidURIError
    errors.add(:full_url,"is not a valid url")
  end
end
