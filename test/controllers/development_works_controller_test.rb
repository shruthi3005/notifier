require 'test_helper'

class DevelopmentWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @development_work = development_works(:one)
  end

  test "should get index" do
    get development_works_url
    assert_response :success
  end

  test "should get new" do
    get new_development_work_url
    assert_response :success
  end

  test "should create development_work" do
    assert_difference('DevelopmentWork.count') do
      post development_works_url, params: { development_work: { department_id: @development_work.department_id, desc: @development_work.desc, estimated_amount: @development_work.estimated_amount, foundation_date: @development_work.foundation_date, inaugration_date: @development_work.inaugration_date, name: @development_work.name, place_id: @development_work.place_id, remarks: @development_work.remarks, sanctioned_amount: @development_work.sanctioned_amount, status: @development_work.status } }
    end

    assert_redirected_to development_work_url(DevelopmentWork.last)
  end

  test "should show development_work" do
    get development_work_url(@development_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_development_work_url(@development_work)
    assert_response :success
  end

  test "should update development_work" do
    patch development_work_url(@development_work), params: { development_work: { department_id: @development_work.department_id, desc: @development_work.desc, estimated_amount: @development_work.estimated_amount, foundation_date: @development_work.foundation_date, inaugration_date: @development_work.inaugration_date, name: @development_work.name, place_id: @development_work.place_id, remarks: @development_work.remarks, sanctioned_amount: @development_work.sanctioned_amount, status: @development_work.status } }
    assert_redirected_to development_work_url(@development_work)
  end

  test "should destroy development_work" do
    assert_difference('DevelopmentWork.count', -1) do
      delete development_work_url(@development_work)
    end

    assert_redirected_to development_works_url
  end
end
