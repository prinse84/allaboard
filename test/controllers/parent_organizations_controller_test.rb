require 'test_helper'

class ParentOrganizationsControllerTest < ActionController::TestCase
  
  # called before every single test
  def setup
    @parent = parent_organizations(:one)
  end
    
  test "should get index page when authenticated as an admin" do
    sign_in users(:admin)
    get :index
    assert_not_nil assigns(:parent_organizations), "Parent organizations were not generated for the index page"
    assert_template :index
    assert_select 'title', "Non-profit organizations directory on The All A-Board Alliance"
    assert_response :success, "Parent Organization index page did not load successfully"
  end
  
  test "should redirect to login page when viewing index page whilst not authenticated" do
    get :index
    assert_redirected_to new_user_session_path, "User could view index page without logging in"
  end
  
  test "should redirect to login page when viewing index page whilst authenticated as a non admin user" do
    sign_in users(:one)
    get :index
    # redirect to boards index page with a warning message
    assert_redirected_to boards_path, "Non-admin user could view index page"
    assert_equal 'You cannot view all organizations, you are not an admin.', flash[:warning]
  end

  test "should get show page" do
    get :show, id: @parent.id
    assert_template :show
    assert_not_nil assigns(:parent_organization), "Parent Organization object was not generated for the show page"
    assert_select 'title', @parent.name + " on The All A-Board Alliance"
    assert_response :success, "Detail page for organization did not load successfully"
  end
  
  test "should redirect to index page if an invalid id value is passed" do 
    get :show, id: '999'
    assert_redirected_to parent_organizations_path
    assert_equal 'The organization you are looking for does not exist', flash[:warning]
  end
  
  test "should redirect to login page when viewing the new page whilst not authenticated" do
    get :new
    assert_redirected_to new_user_session_path, "User could view new page without logging in"
  end
  
  test "should redirect to login page when viewing new page whilst authenticated as a non admin user" do 
    sign_in users(:one)
    get :new
    assert_redirected_to parent_organizations_path, "Non-admin user could view the new page"
    assert_equal "You cannot create a new organization, you are not an admin.", flash[:warning]
  end 
  
  test "should get new page when authenticated as an admin" do
    sign_in users(:admin)
    get :new
    assert_not_nil assigns(:parent_organization), "Parent organization object not gerenated for new page"
    assert_template :new
    assert_select 'title', 'Create a new parent organization: The All A-Board Alliance'
    assert_select 'form'
    assert_response :success, "Parent Organization new page did not load successfully"
  end
  
  test "should create a new organization" do
    assert_difference('ParentOrganization.count' ) do
      post :create, parent_organization: { name: @parent.name, ein: '987654321' }
    end
    assert_equal "New organization created.", flash[:success]
    assert_redirected_to parent_organization_path(assigns(:parent_organization))
  end
  
  test "should fail to create a new organization if required fields are missing" do 
    assert_no_difference('ParentOrganization.count') do
      post :create, parent_organization: { ein: nil }
    end
    assert_equal "An error occurred.", flash[:warning]
    assert_not_nil assigns(:parent_organization), "Parent organization object not gerenated for new page"    
    assert_template 'new'
  end
  
  test "should import a list of organizations" do
    csv_data = "1 Fur 1 Foundation,465204545
    11 10 02 Foundation,364240225
    1261 Foundation,364018186"
    assert_difference('ParentOrganization.count',3 ) do
      post :import, organizations: csv_data
    end
    assert_equal "Organizations imported.", flash[:success]
    assert_redirected_to parent_organizations_path
  end
  
  test "should redirect to login page when viewing the edit page whilst not authenticated" do
    get :edit, id: @parent.id
    assert_redirected_to new_user_session_path, "User could view edit page without logging in"
  end

  test "should redirect to login page when viewing edit page whilst authenticated as a non admin user" do 
    sign_in users(:one)
    get :edit, id: @parent.id
    assert_redirected_to parent_organizations_path, "Non-admin user could view the edit page"
    assert_equal "You cannot edit an organization, you are not an admin.", flash[:warning]
  end
  
  test "should get an edit page when authenticated as an admin" do
    sign_in users(:admin)
    get :edit, id: @parent.id
    assert_not_nil assigns(:parent_organization), "Parent organization object not gerenated for edit page"
    assert_template :edit
    assert_select 'title', 'Edit information for ' + @parent.name + ': The All A-Board Alliance'
    assert_select 'form'
    assert_response :success, "Parent Organization edit page did not load successfully"
  end
  
  test "should update an organization" do
    patch :update, id: @parent, parent_organization: { name: @parent.name, ein: '034241655' }
    assert_equal "Organization details updated.", flash[:success]
    assert_redirected_to parent_organization_path(assigns(:parent_organization))
  end
  
  test "should fail to update an organization if required fields are missing" do 
    patch :update, id: @parent, parent_organization: {ein: nil}
    assert_equal "An error occurred.", flash[:warning]
    assert_not_nil assigns(:parent_organization), "Parent organization object not gerenated for edit page"    
    assert_template 'edit'
  end
  
  test "should destroy an organization" do
    assert_difference('ParentOrganization.count', -1) do
      delete :destroy, id: @parent
    end
    assert_redirected_to parent_organizations_path
  end
  
end
