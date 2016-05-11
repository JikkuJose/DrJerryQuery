module JerryQuery
  class ParenthesisMatcher
    def initialize(pairs)
      @pairs = pairs

      @result = {}
      @result[0] = []
    end

    def possible_matchers(pairs = @pairs)
      return [''] if pairs.zero?

      @result[pairs] ||= opposite_parenthesis(pairs)
        .flat_map do |index|
        pairs_in_between = (index - 1) / 2
        pairs_after = (2 * pairs - index - 1) / 2

        ["("]
          .product(possible_matchers(pairs_in_between))
          .product([")"])
          .product(possible_matchers(pairs_after))
          .flatten
          .each_slice(4)
          .map { |match| match.join }
      end
        .sort
    end

    def opposite_parenthesis(pairs)
      pairs.times.map { |i| 2 * i + 1 }
    end

    def result
      @result[@pairs] || possible_matchers
    end
  end
end

# cli_parameter = ARGV[0].to_i
#
# p JerryQuery::ParenthesisMatcher
#   .new(cli_parameter)
#   .result
