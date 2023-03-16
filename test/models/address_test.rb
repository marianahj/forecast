require "test_helper"

class AddressTest < ActiveSupport::TestCase
  address_attrs = {
      street_1: '750 Test St.',
      street_2: 'Apt 2F',
      city: 'San Francisco',
      state: 'CA',
      zipcode: '94102',
      country_code: 'US'
    }

  test 'initializes the address as a string without street_2' do
    assert Address.new(address_attrs), '750 Test St.,San Francisco,CA,94102,US'
  end

  test 'returns coordinates for given address' do
    address = Address.new(address_attrs)
    assert address.coordinates,[40.7143528, -74.0059731]
  end

  test 'returns an empty array when address not present' do
    address = Address.new()
    assert address.coordinates,[]
  end
end