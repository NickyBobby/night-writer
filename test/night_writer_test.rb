require_relative 'test_helper'
require 'minitest/autorun'
require 'night_writer'

class NightWriterTest < Minitest::Test



  def test_letter_a_braille
    k = NightWriter.new

    assert_equal k.letter_a_braille, ["0.","..",".."]
  end
  def test_letter_ab_braille
    l = NightWriter.new

    assert_equal l.letter_ab_braille, [["0.","..",".."], ["0.","0.",".."]]
  end
  def test_top_line_of_braille
    m = NightWriter.new
    expected = "0."
    assert_equal expected, m.top_line_of_braille
  end

  def test_letter_to_braille
    n = NightWriter.new
    assert_equal ["0.","..",".."], n.letter_to_braille("a")
    assert_equal [["..","..",".0"],["0.","..",".."]], n.letter_to_braille("A")
  end

  def test_sentence_to_braille
    n = NightWriter.new
    assert_equal [["0.","..",".."],["0.","0.",".."]], n.sentence_to_braille("ab")
    assert_equal [[".0","00",".."], ["00","..","0."]], n.sentence_to_braille("jm")
    assert_equal [[["..","..",".0"],["0.","00",".."]],["0.",".0",".."],["0.","0.","0."],["0.","0.","0."],["0.",".0","0."],["..","..",".."],
    [".0","00",".0"],["0.",".0","0."],["0.","00","0."],["0.","0.","0."],["00",".0",".."]], n.sentence_to_braille("Hello world")
  end

  def test_top_line_braille

    n = NightWriter.new
    n.sentence_to_braille("ab")
    assert_equal ["0.","0."], n.top_line_braille
  end

  def test_middle_line_braille
    n = NightWriter.new
    n.sentence_to_braille("ab")
    assert_equal ["..","0."], n.middle_line_braille
  end

  def test_bottom_line_braille
    n = NightWriter.new
    n.sentence_to_braille("ab")
    assert_equal ["..",".."], n.bottom_line_braille
  end


end
