require_relative "chrad/version"

module ChRad
  class Error < StandardError; end
  class InvalidInputError < Error; end

  DEFAULT_BASE = 10
  DEFAULT_INPUT_BASE  = DEFAULT_BASE
  DEFAULT_OUTPUT_BASE = DEFAULT_BASE

  DEFAULT_MODE = :alphabet
  DEFAULT_SEPARATOR = ','
end

require_relative 'chrad/alphabet'
require_relative 'chrad/io_manager'

module ChRad
  DEFAULT_ALPHABET = Alphabet[:base16]
end
