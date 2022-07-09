require_relative "change_base/version"

module ChangeBase
  class Error < StandardError; end
  class InvalidInputError < Error; end

  DEFAULT_BASE = 10
  DEFAULT_INPUT_BASE  = DEFAULT_BASE
  DEFAULT_OUTPUT_BASE = DEFAULT_BASE

  DEFAULT_MODE = :alphabet
  DEFAULT_SEPARATOR = ','
end

require_relative 'change_base/alphabet'
require_relative 'change_base/io_manager'

module ChangeBase
  DEFAULT_ALPHABET = Alphabet[:base16]
end
