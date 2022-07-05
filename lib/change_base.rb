require 'bases'
require_relative "change_base/version"

module ChangeBase
  class Error < StandardError; end

  DEFAULT_BASE = 10
  DEFAULT_INPUT_BASE  = DEFAULT_BASE
  DEFAULT_OUTPUT_BASE = DEFAULT_BASE

  DEFAULT_MODE = :alphabet
  DEFAULT_SEPARATOR = ','
  DEFAULT_ALPHABET = Bases::B64

  class IOConfig
    attr_accessor :stream, :base

    attr_writer :mode, :alphabet, :separator

    def mode
      @mode ||= DEFAULT_MODE
    end

    def separator
      @separator ||= DEFAULT_SEPARATOR
    end

    def alphabet
      @alphabet ||= DEFAULT_ALPHABET
    end

    def parse_base!
      
    end
  end

  class InputOptions < IOConfig
    def initialize
      @base = DEFAULT_INPUT_BASE
      @stream = STDIN
    end
  end

  class OutputOptions < IOConfig
    def initialize
      @base = DEFAULT_OUTPUT_BASE
      @stream = STDOUT
    end
  end

  class Options
    attr_reader :input, :output

    def initialize
      @input  = InputOptions.new
      @output = OutputOptions.new
    end
  end
end
