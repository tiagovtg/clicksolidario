require 'test_helper'

class DoacaosControllerTest < ActionController::TestCase
  setup do
    @doacao = doacaos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:doacaos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doacao" do
    assert_difference('Doacao.count') do
      post :create, :doacao => @doacao.attributes
    end

    assert_redirected_to doacao_path(assigns(:doacao))
  end

  test "should show doacao" do
    get :show, :id => @doacao.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @doacao.to_param
    assert_response :success
  end

  test "should update doacao" do
    put :update, :id => @doacao.to_param, :doacao => @doacao.attributes
    assert_redirected_to doacao_path(assigns(:doacao))
  end

  test "should destroy doacao" do
    assert_difference('Doacao.count', -1) do
      delete :destroy, :id => @doacao.to_param
    end

    assert_redirected_to doacaos_path
  end
end
