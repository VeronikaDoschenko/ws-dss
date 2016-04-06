require 'test_helper'

class WsModelRunsControllerTest < ActionController::TestCase
  setup do
    @ws_model_run = ws_model_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_model_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_model_run" do
    assert_difference('WsModelRun.count') do
      post :create, ws_model_run: { name: @ws_model_run.name, trace: @ws_model_run.trace, ws_model_id: @ws_model_run.ws_model_id, ws_model_status_id: @ws_model_run.ws_model_status_id }
    end

    assert_redirected_to ws_model_run_path(assigns(:ws_model_run))
  end

  test "should show ws_model_run" do
    get :show, id: @ws_model_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_model_run
    assert_response :success
  end

  test "should update ws_model_run" do
    patch :update, id: @ws_model_run, ws_model_run: { name: @ws_model_run.name, trace: @ws_model_run.trace, ws_model_id: @ws_model_run.ws_model_id, ws_model_status_id: @ws_model_run.ws_model_status_id }
    assert_redirected_to ws_model_run_path(assigns(:ws_model_run))
  end

  test "should destroy ws_model_run" do
    assert_difference('WsModelRun.count', -1) do
      delete :destroy, id: @ws_model_run
    end

    assert_redirected_to ws_model_runs_path
  end
end
