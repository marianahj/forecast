class ForecastsController < ApplicationController
  def index; end

  def new
    address = Address.new(address_params)

    if address.coordinates
      open_meteo_service = OpenMeteoService.new(address.coordinates, address.zipcode)
      @forecast  = open_meteo_service.forecast
    else
      @forecast = HashWithIndifferentAccess.new(reason: 'Address invalid', error: true)
    end
  end

  private

  def address_params
    params.permit(:street_1, :street_2, :city, :state, :zipcode, :country_code)
  end
end