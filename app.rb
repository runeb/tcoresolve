require 'net/http'

require "rubygems"
require "bundler/setup"

require 'sinatra'
require 'rack/contrib/jsonp'
require 'json'

use Rack::JSONP

get '/' do
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
    "Try with /?tco=vqjlFcI"
  end
end
