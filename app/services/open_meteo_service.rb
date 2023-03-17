class OpenMeteoService
  attr_reader :coordinates

  BASE_URL = 'https://api.open-meteo.com/v1/forecast'
  DAILY = 'weathercode,temperature_2m_max,temperature_2m_min'
  CURRENT_WEATHER = true
  TEMPERATURE_UNIT = 'fahrenheit'
  WINDSPEED_UNIT = 'mph'
  PRECIPITATION_UNIT = 'inch'
  TIMEFORMAT = 'unixtime'
  TIMEZONE = 'America/Los_Angeles'

  def initialize(coordinates, zipcode)
    @coordinates = coordinates
    @zipcode = zipcode
  end

  def forecast
    if response = Rails.cache.read(@zipcode)
      response.merge(cache: true)
    else
      response = JSON.parse(Net::HTTP.get(url))
      if !response.key?('error')
        Rails.cache.write(@zipcode, response, :expires_in => 30.minutes)
      end
      response
    end
  end

  private

  def url
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(query_params)
    uri
  end

  def query_params
    {
      latitude: latitude,
      longitude: longitude,
      daily: DAILY,
      current_weather: CURRENT_WEATHER,
      temperature_unit: TEMPERATURE_UNIT,
      windspeed_unit: WINDSPEED_UNIT,
      precipitation_unit: PRECIPITATION_UNIT,
      timeformat: TIMEFORMAT,
      start_date: start_date,
      end_date: end_date,
      timezone: TIMEZONE
    }
  end
  def latitude
    coordinates.first
  end

  def longitude
    coordinates.last
  end

  def start_date
    Date.today.to_s
  end

  def end_date
    (Date.today + 7.days).to_s
  end
end