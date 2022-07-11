# frozen_string_literal: true

require "test_helper"

class TestCustomDigits < ChangeBaseTest
  def test_it_can_input_custom_digits
    assert_changes_base  5, 'YXZ', 16, '59', idigits: 'VWXYZ'
    assert_changes_base  5, '+=/', 16, '59', idigits: '_-=+/'
    assert_changes_base  5, '♀♣✔', 16, '59', idigits: '∆☺♣♀✔'
  end

  def test_it_can_output_custom_digits
    assert_changes_base  16, '59', 5, 'YXZ', odigits: 'VWXYZ'
    assert_changes_base  16, '59', 5, '+=/', odigits: '_-=+/'
    assert_changes_base  16, '59', 5, '♀♣✔', odigits: '∆☺♣♀✔'
  end
end
