require 'minitest/autorun'
require_relative './integer_translator.rb'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({color: true})]

class IntegerTranslatorTest < Minitest::Test
  def setup
    @t = JerryQuery::IntegerTranslator
  end

  def test_0
    assert_equal 'Zero', @t.new(0).in_english
  end

  def test_one
    assert_equal 'One', @t.new(1).in_english
  end

  def test_14
    assert_equal 'Fourteen', @t.new(14).in_english
  end

  def test_twenty
    # This really shouldn't be twenty-zero
    assert_equal 'Twenty', @t.new(20).in_english
  end

  def test_twenty_two
    assert_equal 'Twenty Two', @t.new(22).in_english
  end

  def test_100
    assert_equal 'One Hundred', @t.new(100).in_english
  end

  def test_120
    assert_equal 'One Hundred, and Twenty', @t.new(120).in_english
  end

  def test_123
    assert_equal 'One Hundred, and Twenty Three', @t.new(123).in_english
  end

  def test_1_thousand
    assert_equal 'One Thousand', @t.new(1000).in_english
  end

  def test_1_thousand_234
    expected = 'One Thousand, Two Hundred, and Thirty Four'
    assert_equal expected, @t.new(1234).in_english
  end

  def test_12_thousand_234
    expected = 'Twelve Thousand, Two Hundred, and Thirty Four'
    assert_equal expected, @t.new(12234).in_english
  end

  def test_given
    expected = "Sixty Three Thousand, Nine Hundred, and Twelve"
    assert_equal expected, @t.new(63912).in_english
  end

  def test_lower_bound
    assert_raises ArgumentError do
      @t.new(-1).in_english
    end
  end

  def test_upper_bound
    assert_raises ArgumentError do
      @t.new(@t::UPPER_BOUND).in_english
    end
  end
end
