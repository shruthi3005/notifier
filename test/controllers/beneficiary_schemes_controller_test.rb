require 'test_helper'

class BeneficiarySchemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @beneficiary_scheme = beneficiary_schemes(:one)
  end

  test "should get index" do
    get beneficiary_schemes_url
    assert_response :success
  end

  test "should get new" do
    get new_beneficiary_scheme_url
    assert_response :success
  end

  test "should create beneficiary_scheme" do
    assert_difference('BeneficiaryScheme.count') do
      post beneficiary_schemes_url, params: { beneficiary_scheme: { application_date: @beneficiary_scheme.application_date, granted_relief: @beneficiary_scheme.granted_relief, place_id: @beneficiary_scheme.place_id, remarks: @beneficiary_scheme.remarks, schemeType: @beneficiary_scheme.schemeType, status: @beneficiary_scheme.status, user_id: @beneficiary_scheme.user_id } }
    end

    assert_redirected_to beneficiary_scheme_url(BeneficiaryScheme.last)
  end

  test "should show beneficiary_scheme" do
    get beneficiary_scheme_url(@beneficiary_scheme)
    assert_response :success
  end

  test "should get edit" do
    get edit_beneficiary_scheme_url(@beneficiary_scheme)
    assert_response :success
  end

  test "should update beneficiary_scheme" do
    patch beneficiary_scheme_url(@beneficiary_scheme), params: { beneficiary_scheme: { application_date: @beneficiary_scheme.application_date, granted_relief: @beneficiary_scheme.granted_relief, place_id: @beneficiary_scheme.place_id, remarks: @beneficiary_scheme.remarks, schemeType: @beneficiary_scheme.schemeType, status: @beneficiary_scheme.status, user_id: @beneficiary_scheme.user_id } }
    assert_redirected_to beneficiary_scheme_url(@beneficiary_scheme)
  end

  test "should destroy beneficiary_scheme" do
    assert_difference('BeneficiaryScheme.count', -1) do
      delete beneficiary_scheme_url(@beneficiary_scheme)
    end

    assert_redirected_to beneficiary_schemes_url
  end
end
