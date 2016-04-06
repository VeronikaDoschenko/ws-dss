require 'test_helper'

class WsParamsControllerTest < ActionController::TestCase
  setup do
    @ws_param = ws_params(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_params)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_param" do
    assert_difference('WsParam.count') do
      post :create, ws_param: { descr: @ws_param.descr, dim: @ws_param.dim, is_int: @ws_param.is_int, max_val: @ws_param.max_val, min_val: @ws_param.min_val, name: @ws_param.name }
    end

    assert_redirected_to ws_param_path(assigns(:ws_param))
  end

  test "should show ws_param" do
    get :show, id: @ws_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_param
    assert_response :success
  end

  test "should update ws_param" do
    patch :update, id: @ws_param, ws_param: { descr: @ws_param.descr, dim: @ws_param.dim, is_int: @ws_param.is_int, max_val: @ws_param.max_val, min_val: @ws_param.min_val, name: @ws_param.name }
    assert_redirected_to ws_param_path(assigns(:ws_param))
  end

  test "should destroy ws_param" do
    assert_difference('WsParam.count', -1) do
      delete :destroy, id: @ws_param
    end

    assert_redirected_to ws_params_path
  end
end
