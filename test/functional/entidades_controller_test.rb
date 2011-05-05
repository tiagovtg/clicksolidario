require 'test_helper'

class EntidadesControllerTest < ActionController::TestCase
  setup do
    @entidade = entidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entidade" do
    assert_difference('Entidade.count') do
      post :create, :entidade => @entidade.attributes
    end

    assert_redirected_to entidade_path(assigns(:entidade))
  end

  test "should show entidade" do
    get :show, :id => @entidade.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @entidade.to_param
    assert_response :success
  end

  test "should update entidade" do
    put :update, :id => @entidade.to_param, :entidade => @entidade.attributes
    assert_redirected_to entidade_path(assigns(:entidade))
  end

  test "should destroy entidade" do
    assert_difference('Entidade.count', -1) do
      delete :destroy, :id => @entidade.to_param
    end

    assert_redirected_to entidades_path
  end
end
