require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feedback = feedbacks(:one)
  end

  test "should get index" do
    get feedbacks_url
    assert_response :success
  end

  test "should get new" do
    get new_feedback_url
    assert_response :success
  end

  test "should create feedback" do
    assert_difference('Feedback.count') do
      post feedbacks_url, params: { feedback: { action_taken: @feedback.action_taken, department_id: @feedback.department_id, details: @feedback.details, entity_status_id: @feedback.entity_status_id, feedback_type: @feedback.feedback_type, place_id: @feedback.place_id, title: @feedback.title } }
    end

    assert_redirected_to feedback_url(Feedback.last)
  end

  test "should show feedback" do
    get feedback_url(@feedback)
    assert_response :success
  end

  test "should get edit" do
    get edit_feedback_url(@feedback)
    assert_response :success
  end

  test "should update feedback" do
    patch feedback_url(@feedback), params: { feedback: { action_taken: @feedback.action_taken, department_id: @feedback.department_id, details: @feedback.details, entity_status_id: @feedback.entity_status_id, feedback_type: @feedback.feedback_type, place_id: @feedback.place_id, title: @feedback.title } }
    assert_redirected_to feedback_url(@feedback)
  end

  test "should destroy feedback" do
    assert_difference('Feedback.count', -1) do
      delete feedback_url(@feedback)
    end

    assert_redirected_to feedbacks_url
  end
end
