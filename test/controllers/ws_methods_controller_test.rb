require 'test_helper'

class WsMethodsControllerTest < ActionController::TestCase
  setup do
    @ws_method = ws_methods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_methods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_method" do
    assert_difference('WsMethod.count') do
      post :create, ws_method: {  }
    end

    assert_redirected_to ws_method_path(assigns(:ws_method))
  end

  test "should show ws_method" do
    get :show, id: @ws_method
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_method
    assert_response :success
  end

  test "should update ws_method" do
    patch :update, id: @ws_method, ws_method: {  }
    assert_redirected_to ws_method_path(assigns(:ws_method))
  end

  test "should destroy ws_method" do
    assert_difference('WsMethod.count', -1) do
      delete :destroy, id: @ws_method
    end

    assert_redirected_to ws_methods_path
  end
end
