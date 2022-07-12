module ChRad
  module Algorithms
    def self.number_to_base(number, base)
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
