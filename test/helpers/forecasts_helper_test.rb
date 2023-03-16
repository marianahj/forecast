require "test_helper"

class ForecastsHelperTest < ActionView::TestCase
  setup do
    @forecast = JSON.parse(File.read('test/fixtures/files/open_meteo_service_response.json'))
  end

  test 'current_weather' do
    current = { time: 'March 15, 2023', temperature: 30.6, wind_speed: 2.9, weather_code: 'Mainly clear skies' }
    assert_equal current_weather, current
  end

  test 'daily_weather' do
    daily = [{:day=>"Wednesday", :max_temperature=>43.5, :min_temperature=>30.5, :weather_code=>"Violent rain shower"},
             {:day=>"Thursday", :max_temperature=>46.9, :min_temperature=>31.4, :weather_code=>"Partly cloudy"},
             {:day=>"Friday", :max_temperature=>55, :min_temperature=>36.2, :weather_code=>"Partly cloudy"},
             {:day=>"Saturday", :max_temperature=>54.5, :min_temperature=>43.3, :weather_code=>"Partly cloudy"},
             {:day=>"Sunday", :max_temperature=>59.5, :min_temperature=>40.7, :weather_code=>"Partly cloudy"},
             {:day=>"Monday", :max_temperature=>48.5, :min_temperature=>40.2, :weather_code=>"Partly cloudy"}]

    assert_equal daily_weather, daily
  end

  test 'returns weather description of a given code' do
    code = 40
    assert_equal weather_code(code), 'Patchy fog'
  end

  test 'returns time in readable format' do
    unix_time = 1678942800
    assert_equal current_time(unix_time), 'March 15, 2023'
  end

  test 'returns the day of the week for a given unix time' do
    unix_time = 1678942800
    assert_equal day_of_week(unix_time), 'Wednesday'
  end

  test 'returns error message from the open meteo service' do
    @forecast = { 'error' => true, 'reason' => "Value of type 'Float' required for key 'latitude'." }
    assert_equal error_message, "Value of type 'Float' required for key 'latitude'."
  end

  test 'returns error message when address is invalid' do
    @forecast = { error_message: 'Address invalid' }
    assert_equal error_message, 'Address invalid'
  end
end