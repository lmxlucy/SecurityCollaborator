require 'test_helper'

class UserAppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_app = user_apps(:one)
  end

  test "should get index" do
    get user_apps_url
    assert_response :success
  end

  test "should get new" do
    get new_user_app_url
    assert_response :success
  end

  test "should create user_app" do
    assert_difference('UserApp.count') do
      post user_apps_url, params: { user_app: { app_id: @user_app.app_id, q1: @user_app.q1, q2: @user_app.q2, q3: @user_app.q3, q4: @user_app.q4, q5: @user_app.q5, q6: @user_app.q6, user_id: @user_app.user_id } }
    end

    assert_redirected_to user_app_url(UserApp.last)
  end

  test "should show user_app" do
    get user_app_url(@user_app)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_app_url(@user_app)
    assert_response :success
  end

  test "should update user_app" do
    patch user_app_url(@user_app), params: { user_app: { app_id: @user_app.app_id, q1: @user_app.q1, q2: @user_app.q2, q3: @user_app.q3, q4: @user_app.q4, q5: @user_app.q5, q6: @user_app.q6, user_id: @user_app.user_id } }
    assert_redirected_to user_app_url(@user_app)
  end

  test "should destroy user_app" do
    assert_difference('UserApp.count', -1) do
      delete user_app_url(@user_app)
    end

    assert_redirected_to user_apps_url
  end
end
