require 'net/http'

require "rubygems"
require "bundler/setup"

require 'sinatra'
require 'rack/contrib/jsonp'
require 'json'

use Rack::JSONP

get '/' do
  response.headers['Cache-Control'] = 'public, max-age=31536000'
  
  if tco = params[:tco]
    content_type 'application/json'
    url = nil
    Net::HTTP.start('t.co') do |http|
      url = http.request_head('/' + tco)['Location']
    end
    
    unless url
      status 400
      return
    end
    
    return {url: url}.to_json
  else
    File.read(File.join('public', 'index.html'))
  end
end
