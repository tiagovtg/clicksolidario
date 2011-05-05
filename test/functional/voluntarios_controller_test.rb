require 'test_helper'

class VoluntariosControllerTest < ActionController::TestCase
  setup do
    @voluntario = voluntarios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:voluntarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create voluntario" do
    assert_difference('Voluntario.count') do
      post :create, :voluntario => @voluntario.attributes
    end

    assert_redirected_to voluntario_path(assigns(:voluntario))
  end

  test "should show voluntario" do
    get :show, :id => @voluntario.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @voluntario.to_param
    assert_response :success
  end

  test "should update voluntario" do
    put :update, :id => @voluntario.to_param, :voluntario => @voluntario.attributes
    assert_redirected_to voluntario_path(assigns(:voluntario))
  end

  test "should destroy voluntario" do
    assert_difference('Voluntario.count', -1) do
      delete :destroy, :id => @voluntario.to_param
    end

    assert_redirected_to voluntarios_path
  end
end
