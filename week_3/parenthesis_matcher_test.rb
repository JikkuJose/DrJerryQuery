require 'minitest'
require 'minitest/reporters'
require_relative './parenthesis_matcher.rb'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({detailed_skip: false})]

class PMTest < Minitest::Test
  def setup
    @pm = JerryQuery::ParenthesisMatcher
  end

  def test_0
    assert_equal [], @pm.new(0).result
  end

  def test_1
    assert_equal ["()"], @pm.new(1).result
  end

  def test_2
    assert_equal ["(())", "()()"], @pm.new(2).result
  end

  def test_3
    assert_equal ["((()))", "(()())", "(())()", "()(())", "()()()"], @pm.new(3).result
  end
end

Minitest.autorun
