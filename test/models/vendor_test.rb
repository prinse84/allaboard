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

  test "should add 'http' prefix to URL for vendor url when url is populated but the prefix is not present" do
    @vendor.website_url = 'example.com'
    @vendor.save
    assert_equal 'http://example.com', @vendor.website_url, "The 'http' prefix was not added to a vendor URL"
  end

  test "should not add 'http' prefix to URL for vendor url when website_url is populated and the 'http' prefix is present" do
    @vendor.website_url = 'http://example.com'
    @vendor.save
    assert_equal 'http://example.com', @vendor.website_url, "The 'http' prefix was added to a vendor URL even though it was already present"
  end

  test "should not add 'http' prefix to URL for a vendor website url when website_url is populated and the 'https' prefix is present" do
    @vendor.website_url = 'https://example.com'
    @vendor.save
    assert_equal 'https://example.com', @vendor.website_url, "The 'http' prefix was added to a vendor URL even though the 'https' prefix was already present"
  end

  test "should not add 'http' prefix to URL for board url when website_url blank but not nil" do
    @vendor.website_url = ''
    @vendor.save
    assert_not_equal 'http://', @vendor.website_url, "The 'http' prefix was added to a vendor website_url that was blank"
  end

  test "should not add 'http' prefix to URL for board website when website_url is nil" do
    @vendor.website_url = nil
    @vendor.save
    assert_not_equal 'http://', @vendor.website_url, "The 'http' prefix was added to a vendor url that was nil"
  end

end
