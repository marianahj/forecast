class Address
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attrs = attributes.except(:street_2)
  end

  def full_address
    @attrs.values.compact.join(',')
  end

  def coordinates
    return [] if full_address.blank?
    Geocoder.search(full_address).first&.coordinates
  end

  def zipcode
    @attrs[:zipcode]
  end
end