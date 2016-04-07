require 'test_helper'

class WsParamValuesControllerTest < ActionController::TestCase
  setup do
    @ws_param_value = ws_param_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_param_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_param_value" do
    assert_difference('WsParamValue.count') do
      post :create, ws_param_value: { new_value: @ws_param_value.new_value, old_value: @ws_param_value.old_value, ws_model_run_id: @ws_param_value.ws_model_run_id, ws_param_id: @ws_param_value.ws_param_id }
    end

    assert_redirected_to ws_param_value_path(assigns(:ws_param_value))
  end

  test "should show ws_param_value" do
    get :show, id: @ws_param_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_param_value
    assert_response :success
  end

  test "should update ws_param_value" do
    patch :update, id: @ws_param_value, ws_param_value: { new_value: @ws_param_value.new_value, old_value: @ws_param_value.old_value, ws_model_run_id: @ws_param_value.ws_model_run_id, ws_param_id: @ws_param_value.ws_param_id }
    assert_redirected_to ws_param_value_path(assigns(:ws_param_value))
  end

  test "should destroy ws_param_value" do
    assert_difference('WsParamValue.count', -1) do
      delete :destroy, id: @ws_param_value
    end

    assert_redirected_to ws_param_values_path
  end
end
