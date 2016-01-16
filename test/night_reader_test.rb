require 'minitest/autorun'
require 'night_reader'

class NightReaderTest < Minitest::Test

  def test_braille_to_letter
    n = NightReader.new
    assert_equal "a", n.braille_to_letter("0.....")
  end

  def test_braille_to_two_letters
    skip
    n = NightReader.new
    assert_equal "ab", n.braille_to_two_letters("0.....0.0...")
  end
end
