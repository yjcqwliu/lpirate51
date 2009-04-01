# Tests for method "check_utf8_encoding"
# Wolfgang Nadasi-Donner
# Last change: 2007/11/04

require 'lib/guess_utf.rb'
require 'test/unit'

class String
  def asutf8
    self.force_encoding(Encoding.find('utf-8'))
  end
end

class Test_check_utf8_encoding < Test::Unit::TestCase
  def test_correct_examples
    assert_equal(15, "\xEF\xBB\xBFmit einem BOM!".asutf8.check_utf8_encoding)
    assert_equal(34, "Ätsch - der € steht aber schlecht!".asutf8.check_utf8_encoding)
    assert_equal( 4, "\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8.check_utf8_encoding)
    assert_equal( 5, "\xEF\xBB\xBF\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8.check_utf8_encoding)
    assert_equal( 0, "".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEF\xBB\xBF".asutf8.check_utf8_encoding)
  end
  
  def test_other_encodings
    assert_nil("".force_encoding(Encoding.find('ascii')).check_utf8_encoding)
    assert_nil("".force_encoding(Encoding.find('ascii-8bit')).check_utf8_encoding)
    assert_nil("".force_encoding(Encoding.find('us-ascii')).check_utf8_encoding)
    assert_nil("".force_encoding(Encoding.find('binary')).check_utf8_encoding)
    assert_nil("".force_encoding(Encoding.find('shift_jis')).check_utf8_encoding)
    assert_nil("".force_encoding(Encoding.find('sjis')).check_utf8_encoding)
    assert_nil("".force_encoding(Encoding.find('euc-jp')).check_utf8_encoding)
  end
  
  def test_incorrect_examples
    assert_nil("hier kommt was falsches:\xF3".asutf8.check_utf8_encoding)
    assert_nil("\xFF".asutf8.check_utf8_encoding)
    assert_nil("\xE1\xFF".asutf8.check_utf8_encoding)
  end
  
  def test_correct_borderline_cases
    assert_equal( 1, "\x00".asutf8.check_utf8_encoding)
    assert_equal( 1, "\x7F".asutf8.check_utf8_encoding)
  
    assert_equal( 1, "\xC2\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xC2\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xDF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xDF\xBF".asutf8.check_utf8_encoding)
    
    assert_equal( 1, "\xE0\xA0\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE0\xA0\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE0\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE0\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE1\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE1\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE1\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xE1\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEC\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEC\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEC\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEC\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEE\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEE\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEE\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEE\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEF\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEF\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEF\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xEF\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xED\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xED\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xED\x9F\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xED\x9F\xBF".asutf8.check_utf8_encoding)

    assert_equal( 1, "\xF0\x90\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\x90\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\x90\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\x90\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\xBF\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\xBF\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\xBF\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF0\xBF\xBF\xBF".asutf8.check_utf8_encoding)
    
    assert_equal( 1, "\xF1\x80\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\x80\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\x80\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\x80\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\xBF\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\xBF\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\xBF\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF1\xBF\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\x80\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\x80\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\x80\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\x80\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\xBF\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\xBF\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\xBF\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF3\xBF\xBF\xBF".asutf8.check_utf8_encoding)

    assert_equal( 1, "\xF4\x80\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x80\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x80\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x80\xBF\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x8F\x80\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x8F\x80\xBF".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x8F\xBF\x80".asutf8.check_utf8_encoding)
    assert_equal( 1, "\xF4\x8F\xBF\xBF".asutf8.check_utf8_encoding)
  end
end