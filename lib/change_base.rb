require 'bases'
require_relative "change_base/version"

module ChangeBase
  class Error < StandardError; end
  class InvalidInputError < Error; end

  DEFAULT_BASE = 10
  DEFAULT_INPUT_BASE  = DEFAULT_BASE
  DEFAULT_OUTPUT_BASE = DEFAULT_BASE

  DEFAULT_MODE = :alphabet
  DEFAULT_SEPARATOR = ','
  DEFAULT_ALPHABET = Bases::B64

  class IOManager
    attr_accessor :stream
    attr_writer :mode, :base, :alphabet, :separator

    def mode
      @mode ||= DEFAULT_MODE
    end

    def base=(value)
      case value
      when Integer
        @base = value
      when /\A[0-9]+\Z/
        @base = value.to_i
      else
        raise Error, "Trying to set #{name} base to #{value.inspect} (expected an Integer or a string matching /[0-9]+/"
      end
    end

    def separator
      @separator ||= DEFAULT_SEPARATOR
    end

    def alphabet
      @alphabet ||= DEFAULT_ALPHABET
    end

    def setup_base_digits!
      case mode
      when :alphabet
        if base > alphabet.length
          raise Error, "Trying to use base #{base}, but the #{input} alphabet only has #{alphabet.length} characters."
        end

        @base_characters = alphabet[0, base]

      when :list
        # not needed in :list mode

      else
        raise Error, "Invalid mode #{mode.inspect}"
      end
    end
  end

  class InputManager < IOManager
    def initialize
      @base = DEFAULT_INPUT_BASE
      @stream = STDIN
    end

    def name
      'input'
    end

    def parse(str)
      case mode
      when :alphabet
        Bases.val(arg).in_base(input.base)

      when :list
        digits = str.split(separator)
        source_base
        value = Bases::Algorithms.convert_from_base(digits, source_base)
        Bases.val(value).in_base(input.base)

      else
        raise Error, "Invalid mode #{mode.inspect}"
      end
    end
  end

  class OutputManager < IOManager
    def initialize
      @base = DEFAULT_OUTPUT_BASE
      @stream = STDOUT
    end

    def name
      'output'
    end

    def number_to_string(number)
      case mode
      when :alphabet
        number.to_base(base)

      when :list
        list = number.to_base(base, array: true)
        list = list.map do |d|
          n.instance_variable_get(:@source_base).find_index(d)
        end
        list.join(separator)

      else
        raise Error, "Invalid mode #{mode.inspect}"
      end
    end

    def puts(number)
      stream.puts number_to_string(number)
    end
  end
end
