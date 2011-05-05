require 'test_helper'

class NoticiaControllerTest < ActionController::TestCase
  setup do
    @noticium = noticia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:noticia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create noticium" do
    assert_difference('Noticium.count') do
      post :create, :noticium => @noticium.attributes
    end

    assert_redirected_to noticium_path(assigns(:noticium))
  end

  test "should show noticium" do
    get :show, :id => @noticium.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @noticium.to_param
    assert_response :success
  end

  test "should update noticium" do
    put :update, :id => @noticium.to_param, :noticium => @noticium.attributes
    assert_redirected_to noticium_path(assigns(:noticium))
  end

  test "should destroy noticium" do
    assert_difference('Noticium.count', -1) do
      delete :destroy, :id => @noticium.to_param
    end

    assert_redirected_to noticia_path
  end
end
