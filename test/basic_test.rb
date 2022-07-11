# frozen_string_literal: true

require "test_helper"

class TestBasicChangeBase < ChangeBaseTest
  def test_it_can_do_simple_base_10_conversions
    assert_all_base_changes   10, '1275',     2, '10011111011'
    assert_all_base_changes   10, '1275',     4,      '103323'
    assert_all_base_changes   10, '1275',     8,        '2373'
    assert_all_base_changes   10, '1275',    12,         '8a3'
    assert_all_base_changes   10, '1275',    16,         '4fb'
  end

  def test_it_can_do_simple_base_5_conversions
    assert_all_base_changes    5,  '324',     2, '1011001'
    assert_all_base_changes    5,  '324',     4,    '1121'
    assert_all_base_changes    5,  '324',     8,     '131'
    assert_all_base_changes    5,  '324',    12,      '75'
    assert_all_base_changes    5,  '324',    16,      '59'
  end

  def test_it_can_do_base_32_conversions
    assert_all_base_changes    7, '4242',    31,     '1hc', dname: 'base32'
    assert_all_base_changes   13, '8888',    31,     'jp6', dname: 'base32'
    assert_all_base_changes   32,  'cma',    17,    '2age', dname: 'base32'
    assert_all_base_changes   31,  'cma',    29,     'eff', dname: 'base32'
  end
end
