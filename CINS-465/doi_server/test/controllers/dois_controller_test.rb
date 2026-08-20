require 'test_helper'

class DoisControllerTest < ActionController::TestCase
  setup do
    @doi = dois(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dois)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create doi" do
    assert_difference('Doi.count') do
      post :create, doi: { description: @doi.description, doi: @doi.doi }
    end

    assert_redirected_to doi_path(assigns(:doi))
  end

  test "should show doi" do
    get :show, id: @doi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @doi
    assert_response :success
  end

  test "should update doi" do
    patch :update, id: @doi, doi: { description: @doi.description, doi: @doi.doi }
    assert_redirected_to doi_path(assigns(:doi))
  end

  test "should destroy doi" do
    assert_difference('Doi.count', -1) do
      delete :destroy, id: @doi
    end

    assert_redirected_to dois_path
  end
end
