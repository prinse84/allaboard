require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  # called before every single test
  def setup
    @board = boards(:one)
  end

  test "should get index page" do
    skip ("test tbd")
    get :index
    assert_response :success, "Boards index page did not load successfully"
  end
end
