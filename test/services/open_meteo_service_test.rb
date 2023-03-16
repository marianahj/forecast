require "test_helper"

class OpenMeteoServiceTest < ActiveSupport::TestCase
  response = File.read('test/fixtures/files/open_meteo_service_response.json')
  coordinates = [52.52, 13.419998]
  subject = OpenMeteoService.new(coordinates)
  url = subject.send(:url)

  setup do
    stub_request(:get, url).
      to_return(body: response)
  end

  test 'returns a parsed JSON response' do
    assert_equal subject.get, JSON.parse(response)
  end

  test 'returns false for success response' do
    subject.get
    assert_equal subject.error?, false
  end
end