require 'test_helper'

class ScansControllerTest < ActionController::TestCase
  setup do
    @scan = scans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scans)
  end

  test "should create scan" do
    assert_difference('Scan.count') do
      post :create, scan: { name: @scan.name, results: @scan.results }
    end

    assert_response 201
  end

  test "should show scan" do
    get :show, id: @scan
    assert_response :success
  end

  test "should update scan" do
    put :update, id: @scan, scan: { name: @scan.name, results: @scan.results }
    assert_response 204
  end

  test "should destroy scan" do
    assert_difference('Scan.count', -1) do
      delete :destroy, id: @scan
    end

    assert_response 204
  end
end
