module JerryQuery
  class IntegerTranslator
    UPPER_BOUND = 100_000
    TRANSLATIONS = {
      0 => "Zero",
      1 => "One",
      2 => "Two",
      3 => "Three",
      4 => "Four",
      5 => "Five",
      6 => "Six",
      7 => "Seven",
      8 => "Eight",
      9 => "Nine",
      10 => "Ten",
      11 => "Eleven",
      12 => "Twelve",
      13 => "Thriteen",
      14 => "Fourteen",
      15 => "Fifteen",
      16 => "Sixteen",
      17 => "Seventeen",
      18 => "Eighteen",
      19 => "Nineteen",
      20 => "Twenty",
      30 => "Thirty",
      40 => "Forty",
      50 => "Fifty",
      60 => "Sixty",
      70 => "Seventy",
      80 => "Eighty",
      90 => "Ninety",
    }

    def initialize(number)
      @number = number
      fail ArgumentError if invalid?
    end

    def in_english
      translate_four_and_five_digits(@number)
    end

    def translate_four_and_five_digits(number)
      thousands = number / 1000
      remaining = number % 1000

      return translate_three_digits(number) if thousands == 0

      prefix = translate_three_digits(thousands) + " Thousand"

      return prefix if remaining == 0

      prefix + ", " + translate_three_digits(remaining)
    end

    def translate_three_digits(number)
      hundreds = number / 100
      remaining = number % 100
      return translate_two_digits(number) if hundreds == 0

      prefix = TRANSLATIONS[hundreds] + " Hundred"

      return prefix if remaining == 0

      prefix + ", and " + translate_two_digits(remaining)
    end

    def translate_two_digits(number)
      tens = (number / 10) * 10
      units = number % 10

      return translate_one_digit(units) if tens == 0
      return "#{TRANSLATIONS[number]}" if units == 0
      return "#{TRANSLATIONS[number]}" unless between_20_and_100.call(number)

      "#{TRANSLATIONS[tens]} #{translate_one_digit(units)}"
    end

    def translate_one_digit(number)
      TRANSLATIONS[number]
    end

    def between_20_and_100
      -> (x) { x > 20 && x < 100 }
    end

    def invalid?
      @number < 0 || @number >= UPPER_BOUND
    end
  end
end
