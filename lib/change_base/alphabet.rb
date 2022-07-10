
module ChangeBase
  class Alphabet
    B62 = (
      ('A'..'Z').to_a +
      ('a'..'z').to_a +
      (0..9).to_a.map(&:to_s)
    )

    B32rfc = (
      ('A'..'Z').to_a +
      ('2'..'7').to_a
    )

    B32 = (
      ('0'..'9').to_a +
      ('a'..'v').to_a
    )

    B16 = (
      ('0'..'9').to_a +
      ('a'..'f').to_a
    )

    def self.all
      @all ||= Hash.new
    end

    def self.add(name, digits)
      all[name.to_s] = digits
    end

    def self.find(name)
      all[name.to_s]
    end

    def self.[](name)
      find(name)
    end

    def self.names
      all.keys
    end

    add :base62,    B62
    add :base64,    B62 + %w(+ /)
    add :base64url, B62 + %w(- _)
    add :base32rfc, B32rfc
    add :base32,    B32
    add :base16,    B16


    attr_reader :name, :digits

    def initialize(name, digit_chars)
      @name = name
               
      self.digits = digit_chars
    end

    def digits=(value)
      new_digits = []
      case value
      when String
        self.digits = value.each_char.to_a
      
      when Array
        value.each do |ch|
          if new_digits.include?(ch)
            raise InvalidInputError,
                  "Cannot add duplicate characters (\"#{ch}\")"
          else
            new_digits.push ch.to_s
          end
        end
        
      else
        raise Error, "Cannot set digits from a \"${value}\". Expected a list of digits as a String or Array"
      end
    end

    def [](idx)
      digits[idx]
    end

    def to_s
      digits.join('')
    end
  end
end
