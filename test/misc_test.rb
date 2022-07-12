# frozen_string_literal: true

require "test_helper"

class TestMisc < ConvBaseTest
  def test_that_it_has_a_version_number
    refute_nil ::ChRad::VERSION
  end
end
