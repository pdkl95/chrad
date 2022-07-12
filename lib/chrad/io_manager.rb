require_relative 'algorithms'

module ChRad
  class IOManager
    attr_accessor :stream, :base
    attr_writer :mode, :separator
    attr_reader :digits

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

    def alphabet=(str)
      @alphabet = automagic_find_alphabet(str)
    end

    def automagic_find_alphabet(str)
      case str
      when /\Aname:(\w+)\Z/
        Alphabet.find($1) or raise Error, "No digit alphabet named \"#{$1}\""
      else
        Alphabet.new("custom_#{name}", str)
      end
    end

    def setup_base_digits!
      case mode
      when :alphabet
        if base > alphabet.length
          raise Error, "Trying to use base #{base}, but the input alphabet only has #{alphabet.length} characters."
        end

        @digits = alphabet[0, base]

      when :list
        # not needed in :list mode

      else
        raise Error, "Invalid mode #{mode.inspect}"
      end
    end

    def value_to_digit(value)
      raise Error, '@digits == nil' if @digits.nil?
      @digits[value]
    end
  end

  class InputManager < IOManager
    attr_accessor :force_stdin

    def initialize
      @base = DEFAULT_INPUT_BASE
      @stream = $stdin
      @force_stdin = false
    end

    def name
      'input'
    end

    def parse(str)
      case mode
      when :alphabet
        str.reverse.each_char.map.with_index do |c, idx|
          value = digits.index(c)
          if value.nil?
            raise Error, "Input digit #{c.inspect} is not a valid input digit (expected: #{digits.join('')})"
          end
          value * (base ** idx)
        end.reduce(&:+)

      when :list
        digits = str.split(separator).reverse
        digits.map.with_index do |x,idx|
          x.to_i * (base ** idx)
        end.reduce(&:+)

      else
        raise Error, "Invalid mode #{mode.inspect}"
      end
    end
  end

  class OutputManager < IOManager
    def initialize
      @base = DEFAULT_OUTPUT_BASE
      @stream = $stdout
    end

    def name
      'output'
    end

    def number_to_string(number)
      list = Algorithms.number_to_base(number, base)
      list.reverse!

      case mode
      when :alphabet
        list.map do |value|
          value_to_digit(value)
        end.join('')

      when :list
        list.join(separator)

      else
        raise Error, "Invalid mode #{mode.inspect}"
      end
    end

    def stream_puts(number)
      stream.puts number_to_string(number)
    end
  end
end
