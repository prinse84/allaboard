require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  
  # called before every single test
  def setup
    @event = events(:one)
  end

  test "should get index page" do
    get :index
    assert_response :success, "Events index page did not load successfully"
  end

  test "index page should have an event object" do
    get :index
    assert_not_nil assigns(:events), "Events were not generated for the index page"
  end
  
  test "index page should have a categories object" do
    get :index
    assert_not_nil assigns(:categories), "Categories were not generated for the index page"
  end
  
  test "title of index page should be descriptive" do 
    get :index
    assert_select 'title', "Associate Board Events in Chicago: The All A-Board Alliance"
  end
  
  test "should show an event" do
    @event.categories(:category_one)
    get :show, slug: @event.slug
    assert_response :success
  end
  
  test "show page should have objects if a valid slug is passed" do
    get :show, slug: @event.slug
    assert_not_nil assigns(:event)
    assert_not_nil assigns(:categories)
    assert_not_nil assigns(:other_events_by_board)
  end
  
  test "for show action should redirect to event index page if an invalid slug value is passed" do 
    get :show, slug: 'bad-slug-value'
    assert_redirected_to events_path
    assert_equal 'The event you are looking for does not exist', flash[:warning]
  end
  
  test "title of show page should be descriptive" do 
    get :show, slug: @event.slug
    assert_select 'title', @event.name + " by " +  @event.board.name + ": The All A-Board Alliance"
  end
  
  test "for show page should include admin links for admin users" do 
    skip ("test tbd")
    current_user = users(:admin)
    get :show, slug: @event.slug
    assert_select 'small', 'Edit'
  end
  
  test "for show page should include events from past thirty days by the same board" do
    skip ("test tbd")
  end
  
  test "for show page should include events from past thirty days for each of the tags for this event" do
    skip ("test tbd")
  end
  
  test "new page should require authentication" do
    skip ("test tbd")
    session[:user_id] = nil
    get :new
    assert_redirected_to sign_in_path, "User not prompted to authenticate before creating new event"
  end

end
