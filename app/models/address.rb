class Address
  include ActiveModel::Validations

  attr_accessor :street_1, :street_2, :city, :state, :zipcode, :country_code
  attr_reader :address

  def initialize(attributes = {})
    address_attr = attributes.values
    address_attr.delete_at(1) # Geocoder doesn't work with Apt, Unit, Floor, etc.
    @address = address_attr.compact.join(',')
  end

  def coordinates
    return [] if address.blank?

    Geocoder.search(address).first&.coordinates
  end
end