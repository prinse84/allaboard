require 'test_helper'

class VendorsControllerTest < ActionController::TestCase
  
  # called before every single test
  def setup
    @vendor = vendors(:one)
  end
  
  test "should show a vendor" do
    get :show, id: @vendor.id
    assert_response :success
  end
  
  test "show page should have objects if a valid id is passed" do
    get :show, id: @vendor.id
    assert_not_nil assigns(:vendor)
    assert_not_nil assigns(:reviews)
  end
  
  test "for show action should redirect to vendor index page if an invalid id value is passed" do 
    get :show, id: '999'
    assert_redirected_to vendors_path
    assert_equal 'The vendor you are looking for does not exist', flash[:warning]
  end
  
  test "title of show page should be descriptive" do 
    get :show, id: @vendor.id
    assert_select 'title', "Community vendor: " + @vendor.name + " on The All A-Board Alliance"
  end
  
  test "for show page should include admin links for admin users" do 
    skip ("test tbd")
  end
  
end