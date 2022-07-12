# frozen_string_literal: true

require "test_helper"

class TestCustomDigits < ConvBaseTest
  def test_it_can_input_custom_digits
    assert_conv_base  5, 'YXZ', 16, '59', idigits: 'VWXYZ'
    assert_conv_base  5, '+=/', 16, '59', idigits: '_-=+/'
    assert_conv_base  5, '♀♣✔', 16, '59', idigits: '∆☺♣♀✔'
  end

  def test_it_can_output_custom_digits
    assert_conv_base  16, '59', 5, 'YXZ', odigits: 'VWXYZ'
    assert_conv_base  16, '59', 5, '+=/', odigits: '_-=+/'
    assert_conv_base  16, '59', 5, '♀♣✔', odigits: '∆☺♣♀✔'
  end
end
