require 'test_helper'

class WsJobsControllerTest < ActionController::TestCase
  setup do
    @ws_job = ws_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ws_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ws_job" do
    assert_difference('WsJob.count') do
      post :create, ws_job: {  }
    end

    assert_redirected_to ws_job_path(assigns(:ws_job))
  end

  test "should show ws_job" do
    get :show, id: @ws_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ws_job
    assert_response :success
  end

  test "should update ws_job" do
    patch :update, id: @ws_job, ws_job: {  }
    assert_redirected_to ws_job_path(assigns(:ws_job))
  end

  test "should destroy ws_job" do
    assert_difference('WsJob.count', -1) do
      delete :destroy, id: @ws_job
    end

    assert_redirected_to ws_jobs_path
  end
end
