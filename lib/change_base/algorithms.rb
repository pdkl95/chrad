module ChangeBase
  module Algorithms
    def self.number_to_base(number, base)
      puts number.inspect
      puts number.class
      
      if number == 0
        return [0]
      end

      digits = []
      while number > 0
        div, mod = number.divmod(base)
        digits.push(mod)
        number = div
      end

      digits      
    end
  end
end
