require 'test_helper'

class WsSetModelRunsControllerTest < ActionController::TestCase
  setup do
    @ws_set_model_run = ws_set_model_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_set_model_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_set_model_run" do
    assert_difference('WsSetModelRun.count') do
      post :create, ws_set_model_run: { descr: @ws_set_model_run.descr, name: @ws_set_model_run.name }
    end

    assert_redirected_to ws_set_model_run_path(assigns(:ws_set_model_run))
  end

  test "should show ws_set_model_run" do
    get :show, id: @ws_set_model_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_set_model_run
    assert_response :success
  end

  test "should update ws_set_model_run" do
    patch :update, id: @ws_set_model_run, ws_set_model_run: { descr: @ws_set_model_run.descr, name: @ws_set_model_run.name }
    assert_redirected_to ws_set_model_run_path(assigns(:ws_set_model_run))
  end

  test "should destroy ws_set_model_run" do
    assert_difference('WsSetModelRun.count', -1) do
      delete :destroy, id: @ws_set_model_run
    end

    assert_redirected_to ws_set_model_runs_path
  end
end
