require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  # Called before every single test
  def setup
    @board = boards(:Aboard)
  end

  test "should not save board without a name" do
    @board.name = nil
    assert_not @board.save, "The board was saved without a name"
  end

  test "should not save a board without a name that is shorter than three characters" do
    @board.name = 'AB'
    assert_not @board.save, "The board was saved with a name that is shorter than three characters"
  end

  test "should create a slug value upon save" do
    @board.save
    assert_not_nil @board.slug, "A slug for this board was not created"
  end

  test "should create unique slug values for boards" do
    skip ("test tbd")
    @board.name = 'Test Board'
    @board.save
    other_board = boards(:two)
    other_board.name = 'Test Board'
    assert_not other_board.save, "Another board was saved with the same slug value"
    sample_slug = 'test-board' + "-" + Time.now.strftime("%Y%m%d")
    assert_equal sample_slug, other_board.slug, "A unique slug value was not created for a duplicate named board"
  end

  test "should not update slug value if name of board does not change " do
    skip ("test tbd")
    @board.name = 'Test Board'
    @board.save
    original_slug_value = @board.slug
    @board.update_attribute(:name, 'Test Board')
    assert_equal original_slug_value, @board.slug, "The slug name was changed"
  end

  test "should add 'http' prefix to URL for board url when url is populated but the prefix is not present" do
    @board.url = 'example.com'
    @board.save
    assert_equal 'http://example.com', @board.url, "The 'http' prefix was not added to a board URL"
  end

  test "should not add 'http' prefix to URL for board url when url is populated and the 'http' prefix is present" do
    @board.url = 'http://example.com'
    @board.save
    assert_equal 'http://example.com', @board.url, "The 'http' prefix was added to a board URL even though it was already present"
  end

  test "should not add 'http' prefix to URL for a board url when url is populated and the 'https' prefix is present" do
    @board.url = 'https://example.com'
    @board.save
    assert_equal 'https://example.com', @board.url, "The 'http' prefix was added to a board URL even though the 'https' prefix was already present"
  end

  test "should not add 'http' prefix to URL for board url when url blank but not nil" do
    @board.url = ''
    @board.save
    assert_not_equal 'http://', @board.url, "The 'http' prefix was added to a board url that was blank"
  end

  test "should not add 'http' prefix to URL for board url when url is nil" do
    @board.url = nil
    @board.save
    assert_not_equal 'http://', @board.url, "The 'http' prefix was added to a board url that was nil"
  end

  test "should not save board without a parent organization id" do
    skip ("test tbd")
    @board.parent_organization_id = nil
    assert_not @board.save, "The board was saved without a parent organization"
  end

  test "should be associated with a parent organization" do
    assert_respond_to @board, :parent_organization, "The board is not associated with any parent organizations"
  end

  test "should remove '@' for twitter name for board if twitter_name is populated" do
    @board.twitter_name = '@allaboardalliance'
    @board.save
    assert_not_equal '@allaboardalliance', @board.twitter_name, "The '@' sign was not removed from the twitter handle"
  end

  test "should add 'https' prefix to facebook url for board if facebook url is populated" do
    @board.facebook_page_url = 'www.facebook.com/AllABoardAlliance'
    @board.save
    assert_equal 'https://www.facebook.com/AllABoardAlliance', @board.facebook_page_url, "The 'https' prefix was not added to a board URL"
  end

end
