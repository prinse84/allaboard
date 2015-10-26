require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  
  # Called before every single test
  def setup
    @vendor = vendors(:one)
  end
  
  # called after every single test
  def teardown
  end

  test "should not save vendor without a name" do
    @vendor.name = nil
    assert_not @vendor.save, "The vendor was saved without a name"
  end
  
  test "should not save a vendor without a name that is longer than three characters" do
    @vendor.name = 'AB'
    assert_not @vendor.save, "The vendor was saved with a name that is shorter than three characters"
  end
  
  test "should not save vendor without a board id" do
    @vendor.board_id = nil
    assert_not @vendor.save, "The vendor was saved without a board"
  end
  
  test "should be associated with a vendor review" do
    assert_respond_to @vendor, :vendor_reviews, "The vendor is not associated with vendor reviews"
  end
  
  test "should delete vendor reviews when destroyed" do 
    skip ('test tbd')
  end
  
end
