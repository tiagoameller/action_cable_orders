require 'test_helper'

class PlusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plu = plus(:one)
  end

  test "should get index" do
    get plus_url
    assert_response :success
  end

  test "should get new" do
    get new_plu_url
    assert_response :success
  end

  test "should create plu" do
    assert_difference('Plu.count') do
      post plus_url, params: { plu: { name: @plu.name, price: @plu.price, units: @plu.units } }
    end

    assert_redirected_to plu_url(Plu.last)
  end

  test "should show plu" do
    get plu_url(@plu)
    assert_response :success
  end

  test "should get edit" do
    get edit_plu_url(@plu)
    assert_response :success
  end

  test "should update plu" do
    patch plu_url(@plu), params: { plu: { name: @plu.name, price: @plu.price, units: @plu.units } }
    assert_redirected_to plu_url(@plu)
  end

  test "should destroy plu" do
    assert_difference('Plu.count', -1) do
      delete plu_url(@plu)
    end

    assert_redirected_to plus_url
  end
end
