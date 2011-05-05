require 'test_helper'

class NewslettersControllerTest < ActionController::TestCase
  setup do
    @newsletter = newsletters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsletters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsletter" do
    assert_difference('Newsletter.count') do
      post :create, :newsletter => @newsletter.attributes
    end

    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  test "should show newsletter" do
    get :show, :id => @newsletter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @newsletter.to_param
    assert_response :success
  end

  test "should update newsletter" do
    put :update, :id => @newsletter.to_param, :newsletter => @newsletter.attributes
    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  test "should destroy newsletter" do
    assert_difference('Newsletter.count', -1) do
      delete :destroy, :id => @newsletter.to_param
    end

    assert_redirected_to newsletters_path
  end
end
