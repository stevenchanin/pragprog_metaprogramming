require 'minitest/autorun'
require './attribute_validated.rb'

class TestAttrValidatedNoBlock < MiniTest::Unit::TestCase
  class Example
    include AttributeValidated
  end

  def test_initialization
    assert(Example.new.is_a?(Example))
  end

  def test_includes_module
    assert(Example.ancestors.include?(AttributeValidated))
  end

  def test_should_respond_to_attr_validated
    assert(Example.respond_to?(:attr_validated))
  end
end

class TestAttrValidated < MiniTest::Unit::TestCase
  class Example
    include AttributeValidated

    attr_validated :weight do |new_value|
      new_value < 50
    end
  end

  def setup
    @my_example = Example.new
  end

  def test_attr_validated_defines_a_getter
    assert(@my_example.respond_to?(:weight), 'no getter present')
  end

  def test_attr_validated_defines_a_setter
    assert(@my_example.respond_to?(:"weight="), 'no setter present')
  end

  def test_can_set_and_get_value
    @my_example.weight = 10

    assert_equal(10, @my_example.weight, 'calling the getter does not return the set value')
  end

  def test_overrides_value_if_new_value_passes_validation
    @my_example.weight = 10
    @my_example.weight = 15

    assert_equal(@my_example.weight, 15, 'did not save new value')
  end

  def test_ignores_value_if_value_fails_validation
    @my_example.weight = 10
    @my_example.weight = 100

    assert_equal(10, @my_example.weight, 'should have ignored new value')
  end
end
