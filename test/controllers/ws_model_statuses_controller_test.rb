require 'test_helper'

class WsModelStatusesControllerTest < ActionController::TestCase
  setup do
    @ws_model_status = ws_model_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_model_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_model_status" do
    assert_difference('WsModelStatus.count') do
      post :create, ws_model_status: { name: @ws_model_status.name }
    end

    assert_redirected_to ws_model_status_path(assigns(:ws_model_status))
  end

  test "should show ws_model_status" do
    get :show, id: @ws_model_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_model_status
    assert_response :success
  end

  test "should update ws_model_status" do
    patch :update, id: @ws_model_status, ws_model_status: { name: @ws_model_status.name }
    assert_redirected_to ws_model_status_path(assigns(:ws_model_status))
  end

  test "should destroy ws_model_status" do
    assert_difference('WsModelStatus.count', -1) do
      delete :destroy, id: @ws_model_status
    end

    assert_redirected_to ws_model_statuses_path
  end
end
