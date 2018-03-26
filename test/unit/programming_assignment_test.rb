require File.dirname(__FILE__) + '/../test_helper'

class ProgrammingAssignmentTest < ActiveSupport::TestCase

  test 'should randomize list' do
    # Initialize
    size = 20

    ProgrammingAssignment.publicize_methods do
      # Execute
      actual = ProgrammingAssignment.new(size).randomize_list

      # Assertions
      assert_equal size, actual.length
      assert actual.is_a?(Enumerable)
      actual.each { |number| assert number.is_a?(Numeric) }
      # No need to test in-built function shuffle
    end
  end

  test 'should return first half of randomized list' do
    random_numbers          = [10,1,15,6,13,5,12,2,18,16,20,9,14,3,8,4,7,11,19,17]
    expected_random_numbers = [10,1,15,6,13,5,12,2,18,16]
    size                    = 20

    random = ProgrammingAssignment.new(size)
    random.stubs(:randomize_list).returns(random_numbers)

    ProgrammingAssignment.publicize_methods do
      # Execution
      actual = random.first_half

      # Assertions
      assert_equal 10, actual.length
      assert_equal expected_random_numbers, actual
    end
  end

  test 'should separate simple randomised list into appropriate bins' do
    # Initialise
    random_numbers    = [10,1,15,6,13,5,12,2,18,16,20,9,14,3,8,4,7,11,19,17]
    expected_bin_list = [1,1,0,0,1,1,0,0,0,1]
    size              = 20

    random = ProgrammingAssignment.new(size)
    random.stubs(:randomize_list).returns(random_numbers)

    # Execution
    actual = random.bins

    # Assertions
    assert_equal 10, actual.length
    assert_equal expected_bin_list, actual
  end

  test 'should raise error when given size not divisible by 20' do
    caught_exception = assert_raise(RuntimeError) {
      ProgrammingAssignment.new(26)
    }

    assert_equal 'Size {26} is not divisible by 20', caught_exception.message
  end

  test 'should allow numeric string' do
    ProgrammingAssignment.new('20')
  end

  test 'should disallow invalid parameters' do
    caught_exception = assert_raise(RuntimeError) {
      ProgrammingAssignment.new('20a')
    }

    assert_equal 'Unsupported type found {String}', caught_exception.message

    caught_exception = assert_raise(RuntimeError) {
      ProgrammingAssignment.new([])
    }

    assert_equal 'Unsupported type found {Array}', caught_exception.message
  end

  test 'should raise error when given size less than 20' do
    caught_exception = assert_raise(RuntimeError) {
      ProgrammingAssignment.new(19)
    }

    assert_equal 'Size needs to be >= 20', caught_exception.message
  end

  test 'should raise an error when given a odd number' do
    caught_exception = assert_raise(RuntimeError) {
      ProgrammingAssignment.new(25)
    }

    assert_equal 'Size must be an even number', caught_exception.message
  end

  test 'should return graph labels' do
    actual = ProgrammingAssignmentDecorator.decorate(ProgrammingAssignment.new(200))
    assert_equal "[\"1 to 10\",\"11 to 20\",\"21 to 30\",\"31 to 40\",\"41 to 50\",\"51 to 60\",\"61 to 70\",\"71 to 80\",\"81 to 90\",\"91 to 100\"]", actual.labels
  end
end