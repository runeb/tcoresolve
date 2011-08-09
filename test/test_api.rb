# test.rb
require_relative 'test_helper'

class MyTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app() Sinatra::Application end

  def test_resolve_tco_link
    get '/?tco=npByuED'
    assert last_response.ok?
    assert_equal "application/json", last_response.headers['Content-Type']
    assert_equal "http://www.minaksjon.rodekors.no/start-min-egen-innsamling/afrikas-horn/innsamling.aspx?CollectionId=785", JSON.parse(last_response.body)['url']
  end
  
  def test_invalid_tco_link
    get '/?tco=bad_id'
    assert_equal last_response.status, 400
    assert_equal "", last_response.body
  end
  
  def test_jsonp
    get '/?tco=npByuED&callback=parser'
    assert last_response.ok?
    assert_equal "application/javascript", last_response.headers['Content-Type']
  end
end
