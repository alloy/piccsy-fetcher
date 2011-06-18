require "config"

require "net/http"
require "uri"

page = 1
loop do
  puts "Get page: #{page}"
  url = URI.parse("http://#{USERNAME}.piccsy.com")
  res = Net::HTTP.start(url.host, url.port) { |http| http.get("/?page=#{page}") }
  body = res.body.force_encoding('UTF-8')
  body.gsub(/http:\/\/images.piccsy.com\/cache\/images\/.+?\.jpg/m) do |url|
    # loop over all image links on the page, these are the low res versions btw
    filename = File.basename(url)
    path = File.join(OUTPUT_DIR, filename)
    if File.exist?(path)
      puts "The file `#{filename}' already exists. Cancelling further downloads."
      exit
    else
      puts "Downloading: #{url}"
      unless system("curl '#{url}' -o '#{path}'")
        puts "Failed to download."
        exit 1
      end
    end
    nil
  end
  # give the server some rest after every page
  sleep 5
  page += 1
end
