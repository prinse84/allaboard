require 'test_helper'

class ParentOrganizationTest < ActiveSupport::TestCase
  # Called before every single test
  def setup
    @parent = parent_organizations(:one)
  end

  test "should not save a parent organization without a name" do
    @parent.name = nil
    assert_not @parent.save, "The parent organization was saved without a name"
  end

  test "should not save a parent organization without a name that is longer than three characters" do
    @parent.name = 'AB'
    assert_not @parent.save, "The parent organization was saved with a name that is shorter than three characters"
  end

  test "should not save a parent organization without an ein" do
    @parent.ein = nil
    assert_not @parent.save, "The parent organization was saved without an ein"
  end

  test "should not save an organization without a unique ein" do
    @parent_2 = parent_organizations(:two)
    assert_not @parent_2.save, "Another parent organization with the same EIN as saved"
  end

  test "should not save a parent organization with an ein that is longer than 9 characters" do
    @parent.ein = '1234567890'
    assert_not @parent.save, "The ein for the parent organization was longer than 9 characters"
  end

  test "should not save a parent organization with an ein that is shorter than 9 characters" do
    @parent.ein = '12345678'
    assert_not @parent.save, "The ein for the parent organization was shorter than 9 characters"
  end

  test "should not save a parent organization with an ein that is not all numbers" do
    @parent.ein = '12-345678'
    assert_not @parent.save, "The ein for the parent organization was all not numerical"
  end

  test "should return a formatted ein for a parent organization" do
    @parent.ein = '123456789'
    assert_equal '12-3456789', @parent.formatted_ein, "Parent organization object couldn't return a properly formatted ein"
  end

  test "should import a csv list of organizations" do
    # create list of 10 records for testing
    csv_data = "1 Fur 1 Foundation,465204545
    11 10 02 Foundation,364240225
    1261 Foundation,364018186
    1335 Foundation,363701371
    137 Films Nfp,342007905
    15th Ward Organization Crime Stoppers,363527938
    1614-1622 Jonquil Terrace,260558544
    16th Street Church of God in Christ,363934615
    180 Degrees Consulting US Nfp,465092788
    1883 Fund,272998843
    1 Fur 1 Foundation,465204545"
    # hardcode 10 for difference testing
    assert_difference('ParentOrganization.count', 10) do
      ParentOrganization.import(csv_data)
    end
  end

  test "should be related to a board" do
    skip ("Test TBD")
  end

end
