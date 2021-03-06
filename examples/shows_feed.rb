require 'bundler'
Bundler.setup(:default, :development)

require 'artsy-client'

Artsy::Client.authenticate!

cursor = nil
3.times do
  options = {}
  options[:cursor] = cursor if cursor
  r = Artsy::Client.shows_feed(options)
  r[:results].each do |show|
    puts "#{show.name}"
    show.artworks.each do |artwork|
      puts "  #{artwork.title}, #{artwork.date}"
    end
  end
  cursor = r[:next]
  break unless cursor
end
