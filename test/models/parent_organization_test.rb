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
  
end

