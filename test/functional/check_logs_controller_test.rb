require 'test_helper'

class CheckLogsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:check_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create check_log" do
    assert_difference('CheckLog.count') do
      post :create, :check_log => { }
    end

    assert_redirected_to check_log_path(assigns(:check_log))
  end

  test "should show check_log" do
    get :show, :id => check_logs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => check_logs(:one).to_param
    assert_response :success
  end

  test "should update check_log" do
    put :update, :id => check_logs(:one).to_param, :check_log => { }
    assert_redirected_to check_log_path(assigns(:check_log))
  end

  test "should destroy check_log" do
    assert_difference('CheckLog.count', -1) do
      delete :destroy, :id => check_logs(:one).to_param
    end

    assert_redirected_to check_logs_path
  end
end
