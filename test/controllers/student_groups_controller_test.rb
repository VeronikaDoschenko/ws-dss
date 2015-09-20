require 'test_helper'

class StudentGroupsControllerTest < ActionController::TestCase
  setup do
    @student_group = student_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_group" do
    assert_difference('StudentGroup.count') do
      post :create, student_group: { name: @student_group.name, year: @student_group.year }
    end

    assert_redirected_to student_group_path(assigns(:student_group))
  end

  test "should show student_group" do
    get :show, id: @student_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student_group
    assert_response :success
  end

  test "should update student_group" do
    patch :update, id: @student_group, student_group: { name: @student_group.name, year: @student_group.year }
    assert_redirected_to student_group_path(assigns(:student_group))
  end

  test "should destroy student_group" do
    assert_difference('StudentGroup.count', -1) do
      delete :destroy, id: @student_group
    end

    assert_redirected_to student_groups_path
  end
end
