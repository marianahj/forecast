class ForecastsController < ApplicationController
  def index; end

  def new
    coordinates = Address.new(address_params).coordinates

    if coordinates
      # Add Cache
      open_meteo_service = OpenMeteoService.new(coordinates)
      @forecast  = open_meteo_service.get
      @error = open_meteo_service.error?
    else
      @forecast = { error_message: 'Address invalid' }
      @error = true
    end
  end

  private

  def address_params
    params.permit(:street_1, :street_2, :city, :state, :zipcode, :country_code)
  end
end