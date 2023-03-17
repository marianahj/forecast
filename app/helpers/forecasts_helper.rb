module ForecastsHelper
  DAYS_TO_FORECAST = 7
  WEATHER_CODES = {'-8' => 'Thick cirrus clouds', '-7' => 'Snow storm', '-6' => 'Storm' , '-5' => 'Freezing rain', '-4' => 'Heavy snow', '-3' => 'Heavy rain', '-2' => 'Heavy rain' ,'-1' => 'Clear skies' ,'0' => 'Mainly clear skies' ,'1' => 'Mainly Fair' ,'2' => 'Lengthy clear spells' ,'3' => 'Partly cloudy' ,'4' => 'Broken clouds' ,'5' => 'Rather cloudy' ,'6' => 'Mainly cloudy' ,'7' => 'Overcast' ,'8' => '???' ,'9' => 'Mist' ,'10' => 'ground fog' ,'11' => 'ground fog' ,'12' => 'Sheet Lightning' ,'13' => 'Some showers' ,'14' => 'Some showers' ,'15' => 'Some showers', '16' =>  'Isolated thunderstorm',  '17' => 'Wind gusts', '18' => 'Spouts' , '19' => 'Possible Drizzle', '20' => 'Possible Rain', '21' => 'Possible Snow', '22' => 'Light rain and snow' ,'23' => 'Light freezing rain' ,'24' => 'Light rain shower' ,'25' => 'Light snow shower' ,'26' => 'Light shower of snow pellets or rain/snow mixed' ,'27' => 'Possible Fog' ,'28' => 'Isolated thunderstorm' ,'29' => 'Sandstorm' ,'30' => 'Sandstorm' ,'31' => 'Sandstorm' ,'32' => 'Heavy sandstorm' ,'33' => 'Heavy sandstorm' ,'34' => 'Heavy sandstorm' ,'35' => 'Snow flurry' ,'36' => 'Heavy Snow flurry' ,'37' => 'Drifting snow' ,'38' => 'Heavy Drifting snow' ,'39' => 'Patchy fog', '40' =>  'Patchy fog',  '41' => 'Fog', '42' => 'Fog' , '43' =>'Fog', '44' => 'Dense fog', '45' => 'Dense fog', '46' => 'Freezing fog' ,'47' => 'Freezing fog' ,'48' => 'Light Occasional drizzle' ,'49' => 'Light Drizzle' ,'50' => 'Occasional Drizzle' ,'51' => 'Drizzle' ,'52' => 'Occasional Heavy Drizzle' ,'53' => 'Heavy Drizzle' ,'54' => 'Freezing drizzle' ,'55' => 'Freezing rain' ,'56' => 'Drizzle and Rain' ,'57' => 'Drizzle and Rain' ,'58' => 'Occasional rain' ,'59' => 'Light rain' ,'60' => 'Occasional Rain' ,'61' => 'Rain' ,'62' => 'Occasional Heavy rain' ,'63' => 'Heavy rain', '64' =>  'Freezing rain',  '65' => 'Freezing rain', '66' => 'Rain and snow' , '67' => 'Heavy rain and snow', '68' => 'Occasional snow', '69' => 'Light snow', '70' => 'Occasional Snow' ,'71' => 'Snow' ,'72' => 'Occasional Heavy snow' ,'73' => 'Heavy snow' ,'74' => 'Diamond dust' ,'75' => 'Snow grains' ,'76' => 'Snow crystals' ,'77' => 'Ice pellets' ,'78' => 'Rain shower' ,'79' => 'Heavy rain shower' ,'80' => 'Violent rain shower' ,'81' => 'Rain and snow shower' ,'82' => 'Heavy rain and snow shower' ,'83' => 'Snow shower' ,'84' => 'Heavy snow shower' ,'85' => 'Shower of snow pellets or rain/snow mixed' ,'86' => 'Heavy shower of snow pellets or rain/snow mixed' ,'87' => 'Hail shower', '89' => 'Heavy hail shower', '90' => 'Thunderstorms' ,'91' => 'Thunderstorms', '92' => 'Thunderstorms', '93' => 'Thunderstorms' ,'94' => 'Thunderstorms', '95' => 'Thunderstorms', '96' => 'Heavy Thunderstorms', '97' => 'Heavy thunderstorms with sandstorm', '98' => 'Heavy thunderstorms with sandstorm', '99' => 'Heavy thunderstorms with hail or gusts', '100' => 'Not Defined'}

  def current_weather
    {
      time: current_time(@forecast['current_weather']['time']),
      temperature: @forecast['current_weather']['temperature'],
      wind_speed: @forecast['current_weather']['windspeed'],
      weather_code: weather_code(@forecast['current_weather']['weathercode'])
    }
  end

  def daily_weather
    daily_attrs = @forecast['daily']
    daily = []
    (DAYS_TO_FORECAST).times do |i|
      daily << {
        day: day_of_week(daily_attrs['time'][i]),
        max_temperature: daily_attrs['temperature_2m_max'][i],
        min_temperature: daily_attrs['temperature_2m_min'][i],
        weather_code: weather_code(daily_attrs['weathercode'][i])
      }
    end
    daily
  end

  def weather_code(code)
    WEATHER_CODES.fetch(code.to_s || 100)
  end

  def current_time(unix_time)
    (Time.at(unix_time).to_date).strftime("%B %d, %Y")
  end

  def day_of_week(unix_time)
    Date::DAYNAMES[Time.at(unix_time).wday]
  end

  def error?
    @forecast['error']
  end

  def error_message
    @forecast['reason']
  end

  def from_cache?
    @forecast[:cache]
  end

end
