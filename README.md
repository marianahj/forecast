# forecast

Get the current and next week forecast for your address.
## Requirements
- Ruby 3.2.1

## How to run
1. Clone the repo
   ```
   git clone git@github.com:marianahj/forecast.git
   ```
2. Install gems
   ```
   bundle install
   ```
3. Run your local server
    ```
    bin/rails server
    ```
4. Go to your localhost in the browser
   ```
   http://localhost:3000/
   ```

## Assumptions

- The address provided must be valid.
- Address Line 1 and Zip Code are mandatory fields.
- The forecast is cached for 30 minutes based on the zip code.
- No database is needed.


## APIs / Libraries used

- [Open-Meteo Weather Forecast API](https://open-meteo.com/en/docs) 
- [geocoder Gem](https://github.com/alexreisner/geocoder)
- [iso_country_codes Gem](https://github.com/alexrabarts/iso_country_codes)
- [weather-codes Dictionary](https://github.com/MeteoGroup/weather-api/blob/master/FORECAST-WEATHER-API-WeatherCode.md)


- webmock
- pry
- sassc-rails

## Solution

### Controllers
I created the `ForecastsController` with two methods:
- `ForecastsController#index`: is the home page where the address form is displayed.
- `ForecastsController#new`: receives the address from the form and makes the request to
the Weather Forecast API, it redirects to `forecast/new` to display the data.

### Models
The Weather Forecast API works with coordinates, in order to get the coordinates (`.coordinates`) for the  given address, I created
the `Address` model. This model converts the address params into a String needed to get the coordinates using then geocoder gem.

I realized that the `geocoder` gem won't return a search result if I added the Address Line 2 (Apt, Unit, Floor, etc.). 
I decided to still include it in the form to minimized the chance that the user will add that information into the Address Line 1. In
order to have more possibility to get a search result, I used a dropdown to select the Country. The countries data
comes from the `iso_country_codes` gem.

### Services
I created the `OpenMeteoService` as an API wrapper, it contains all the functionality to communicate with the API
and it returns a JSON with the data. If the API responds with an error, it responds with the error description message.

### Helpers
I am using the `ForecastsHelper` to build the data objects needed in the views. It transforms data into a readable format, for example:
converts the unix time into readable dates or day of the week, translates the `weather_code` into its description from the weather codes dictionary. 

### Test
I added unit test for the models, helpers and services. I'm using the `webmock` gem to stub the requests to the 
Weather Forecast API. The API test response files are found in the `fixtures/files` folder. I'm also stubbing a default 
geocoder search as shown in the gem documentation. 

## Improvements
While working in this exercise, I decided to focus on the MVP because I didn't want to over engineer 
and because of the time frame, however, I identify some possible improvements:
1. Single page app: render the address form and the forecast tables in the same page using RoR and Javascript.
2. Add Integration tests.
3. Add validations to the form fields.






