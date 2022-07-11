# frozen_string_literal: true

require "test_helper"

class TestListChangeBase < ChangeBaseTest
  def assert_changes_base_to_list(*args)
    assert_changes_base(*args, args: ['--output-list'])
  end

  def assert_changes_base_from_list(*args)
    assert_changes_base(*args, args: ['--input-list'])
  end

  def test_it_can_output_lists
    assert_changes_base_to_list   10, '1275',     2, '1,0,0,1,1,1,1,1,0,1,1'
    assert_changes_base_to_list   10, '1275',     4,           '1,0,3,3,2,3'
    assert_changes_base_to_list   10, '1275',     8,               '2,3,7,3'
    assert_changes_base_to_list   10, '1275',    12,                '8,10,3'
    assert_changes_base_to_list   10, '1275',    16,               '4,15,11'

    assert_changes_base_to_list    5,  '324',     2, '1,0,1,1,0,0,1'
    assert_changes_base_to_list    5,  '324',     4,       '1,1,2,1'
    assert_changes_base_to_list    5,  '324',     8,         '1,3,1'
    assert_changes_base_to_list    5,  '324',    12,           '7,5'
    assert_changes_base_to_list    5,  '324',    16,           '5,9'
  end

  def test_it_can_input_lists
    assert_changes_base_from_list   2, '1,0,0,1,1,1,1,1,0,1,1',   10, '1275'
    assert_changes_base_from_list   4,           '1,0,3,3,2,3',   10, '1275'
    assert_changes_base_from_list   8,               '2,3,7,3',   10, '1275'
    assert_changes_base_from_list  12,                '8,10,3',   10, '1275'
    assert_changes_base_from_list  16,               '4,15,11',   10, '1275'

    assert_changes_base_from_list     2, '1,0,1,1,0,0,1',    5,  '324'
    assert_changes_base_from_list     4,       '1,1,2,1',    5,  '324'
    assert_changes_base_from_list     8,         '1,3,1',    5,  '324'
    assert_changes_base_from_list    12,           '7,5',    5,  '324'
    assert_changes_base_from_list    16,           '5,9',    5,  '324'
  end
end
