require 'test_helper'

class EntityStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entity_status = entity_statuses(:one)
  end

  test "should get index" do
    get entity_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_entity_status_url
    assert_response :success
  end

  test "should create entity_status" do
    assert_difference('EntityStatus.count') do
      post entity_statuses_url, params: { entity_status: { code: @entity_status.code, entity_type: @entity_status.entity_type, name: @entity_status.name } }
    end

    assert_redirected_to entity_status_url(EntityStatus.last)
  end

  test "should show entity_status" do
    get entity_status_url(@entity_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_entity_status_url(@entity_status)
    assert_response :success
  end

  test "should update entity_status" do
    patch entity_status_url(@entity_status), params: { entity_status: { code: @entity_status.code, entity_type: @entity_status.entity_type, name: @entity_status.name } }
    assert_redirected_to entity_status_url(@entity_status)
  end

  test "should destroy entity_status" do
    assert_difference('EntityStatus.count', -1) do
      delete entity_status_url(@entity_status)
    end

    assert_redirected_to entity_statuses_url
  end
end
