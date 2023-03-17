require "test_helper"

class OpenMeteoServiceTest < ActiveSupport::TestCase
  response = File.read('test/fixtures/files/open_meteo_service_response.json')
  coordinates = [52.52, 13.419998]
  zipcode = '94127'
  subject = OpenMeteoService.new(coordinates, zipcode)
  url = subject.send(:url)

  setup do
    stub_request(:get, url).
      to_return(body: response)
  end

  test"adds the cache:true key when returning from cache" do
    assert_equal subject.forecast, JSON.parse(response).merge(cache: true)
  end

  test 'returns a parsed JSON response' do
    assert_equal subject.forecast, JSON.parse(response)
  end

end