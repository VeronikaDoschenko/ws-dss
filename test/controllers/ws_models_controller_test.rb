require 'test_helper'

class WsModelsControllerTest < ActionController::TestCase
  setup do
    @ws_model = ws_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_model" do
    assert_difference('WsModel.count') do
      post :create, ws_model: { descr: @ws_model.descr, name: @ws_model.name, url: @ws_model.url }
    end

    assert_redirected_to ws_model_path(assigns(:ws_model))
  end

  test "should show ws_model" do
    get :show, id: @ws_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_model
    assert_response :success
  end

  test "should update ws_model" do
    patch :update, id: @ws_model, ws_model: { descr: @ws_model.descr, name: @ws_model.name, url: @ws_model.url }
    assert_redirected_to ws_model_path(assigns(:ws_model))
  end

  test "should destroy ws_model" do
    assert_difference('WsModel.count', -1) do
      delete :destroy, id: @ws_model
    end

    assert_redirected_to ws_models_path
  end
end
