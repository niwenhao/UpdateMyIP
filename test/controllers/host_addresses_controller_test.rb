require 'test_helper'

class HostAddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @host_address = host_addresses(:one)
  end

  test "should get index" do
    get host_addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_host_address_url
    assert_response :success
  end

  test "should create host_address" do
    assert_difference('HostAddress.count') do
      post host_addresses_url, params: { host_address: { hostname: @host_address.hostname, ip: @host_address.ip } }
    end

    assert_redirected_to host_address_url(HostAddress.last)
  end

  test "should show host_address" do
    get host_address_url(@host_address)
    assert_response :success
  end

  test "should get edit" do
    get edit_host_address_url(@host_address)
    assert_response :success
  end

  test "should update host_address" do
    patch host_address_url(@host_address), params: { host_address: { hostname: @host_address.hostname, ip: @host_address.ip } }
    assert_redirected_to host_address_url(@host_address)
  end

  test "should destroy host_address" do
    assert_difference('HostAddress.count', -1) do
      delete host_address_url(@host_address)
    end

    assert_redirected_to host_addresses_url
  end
end
