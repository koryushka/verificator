# frozen_string_literal: true
class AdsFetcher
  URI = 'http://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'

  def ads
    JSON.parse(parsed_response)['ads']
  end

  private

  def parsed_response
    @parsed_response ||= HTTParty.get(uri).parsed_response
  end

  def uri
    URI
  end
end
