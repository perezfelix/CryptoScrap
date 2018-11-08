require 'rubygems'
require 'nokogiri'
require 'open-uri'

class StartScrap


  def initialize
  	@document = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  	@crypto = Crypto.new
  end

  def perform
  	rows = @document.xpath('//*[@id="currencies-all"]/tbody').css('tr')
  	rows.each do |row|
  		price = row.css('td[5]').text
  		@crypto = Crypto.create!(name: row.css('td[2]').text.strip, price: price.strip[1..-1].to_f)
    end
  end
  def update
  	id = 0
  	rows = @document.xpath('//*[@id="currencies-all"]/tbody').css('tr')
  	rows.each do |row|
  		id += 1
  		price = row.css('td[5]').text
  		@crypto = Crypto.find(id)
  		@crypto.update(name: row.css('td[2]').text.strip, price: price.strip[1..-1].to_f)
  	end
  end
end