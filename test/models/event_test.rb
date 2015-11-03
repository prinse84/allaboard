require 'test_helper'

class EventTest < ActiveSupport::TestCase

  # Called before every single test
  def setup
    @event = events(:one)
  end

  # called after every single test
  def teardown
  end

  test "should not save event without a title" do
    @event.name = nil
    assert_not @event.save, "The event was saved without a title"
  end

  test "should not save an event without a title that is shorter than three characters" do
    @event.name = 'AB'
    assert_not @event.save, "The event was saved with a title that is shorter than three characters"
  end

  test "should not save event without a description" do
    @event.description = nil
    assert_not @event.save, "The event was saved without a description"
  end

  test "should not save event without a date" do
    @event.date = nil
    assert_not @event.save, "The event was saved without a date"
  end

  test "should not save event without a location" do
    @event.location = nil
    assert_not @event.save, "The event was saved without a location"
  end

  test "should not save event without a start time" do
    @event.start_time = nil
    assert_not @event.save, "The event was saved without a start time"
  end

  test "should create a slug value upon save" do
    @event.save
    assert_not_nil @event.slug, "A slug for this event was not created"
  end

  test "should create unique slug values for duplicate titled events" do
    @event.name = 'Test Event'
    @event.save
    other_event = events(:two)
    other_event.name = 'Test Event'
    other_event.save
    sample_slug = 'test-event' + "-" + other_event.date.strftime("%Y") + "-" + other_event.date.strftime("%m") + "-" + other_event.date.strftime("%d")
    assert_equal sample_slug, other_event.slug, "A unique slug value was not created for a duplicate titled event"
  end

  test "should not save event without a board id" do
    @event.board_id = nil
    assert_not @event.save, "The event was saved without a board"
  end

  test "should add 'http' prefix to URL for event url when event_url is populated but the prefix is not present" do
    @event.event_url = 'example.com'
    @event.save
    assert_equal 'http://example.com', @event.event_url, "The 'http' prefix was not added to an event_url"
  end

  test "should not add 'http' prefix to URL for event url when event_url is populated and the 'http' prefix is present" do
    @event.event_url = 'http://example.com'
    @event.save
    assert_equal 'http://example.com', @event.event_url, "The 'http' prefix was added to an event_url even though it was already present"
  end

  test "should not add 'http' prefix to URL for event url when event_url is populated and the 'https' prefix is present" do
    @event.event_url = 'https://example.com'
    @event.save
    assert_equal 'https://example.com', @event.event_url, "The 'http' prefix was added to an event_url even though the 'https' prefix was already present"
  end

  test "should not add 'http' prefix to URL for event url when event_url blank but not nil" do
    @event.event_url = ''
    @event.save
    assert_not_equal 'http://', @event.event_url, "The 'http' prefix was added to an event_url that was blank"
  end

  test "should not add 'http' prefix to URL for event url when event_url is nil" do
    @event.event_url = nil
    @event.save
    assert_not_equal 'http://', @event.event_url, "The 'http' prefix was added to an event_url that was nil"
  end

  test "should return a formatted date and start time for an event" do
    @event.date = '2015-10-22'
    @event.start_time = '2015-10-22 18:00:00'
    @event.end_time = '2015-10-22 21:00:00'
    assert_equal 'October 22, 2015 from 06:00PM to 09:00PM', @event.formatted_date, "Event couldn't return a properly formatted date"

    #Test to make sure date is properly formatted if an end time isn't provided
    @event.end_time = nil
    assert_equal 'October 22, 2015 starting at 06:00PM', @event.formatted_date, "Event couldn't return a properly formatted date"

    # test to make sure date is properly formatted if start time and end time aren't provided
    @event.start_time = nil
    assert_equal 'October 22, 2015', @event.formatted_date, "Event couldn't return a properly formatted date"
  end

  test "should return an array of other events within the same category within a certain time period" do
    # event.yaml created 10 events same as event 'two.' Test must equal 10 even though event 'two' falls within the time period.
    # the requirement is that the existing event should not show up in the result set
    # (probably not the best test, good for now)
    @event_two = events(:two)
    assert_equal 10, @event_two.get_other_events_tagged_like_this_one(Time.now.weeks_ago(4)).count, 'Function did not return events within the given time period'

    @event_three = events(:three)
    # event.yaml created 10 events same as event 'three.' Test must equal 10.
    # (probably not the best test, good for now)
    assert_equal 10, @event_three.get_other_events_tagged_like_this_one(Time.now.weeks_ago(4)).count, 'Function did not return events within the given time period'

  end

  test "should be associated with a category" do
    assert_respond_to @event, :categories, "The event is not associated with categories"
  end

end
