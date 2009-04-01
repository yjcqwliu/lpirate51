# Tests for method "remove_utf8_bom"
# Wolfgang Nadasi-Donner
# Last change: 2007/11/04

require 'lib/guess_utf.rb'
require 'test/unit'

class String
  def asutf8
    self.force_encoding(Encoding.find('utf-8'))
  end
end

class Test_remove_utf8_bom < Test::Unit::TestCase
  def test_data_with_utf8_bom
    assert("\xEF\xBB\xBF".asutf8.remove_utf8_bom.eql?("".asutf8))
    # Characters in String:
    # Codepoint U+0040 (COMMERCIAL AT)             - utf-8 encoding: 0x40
    # Codepoint U+03BB (GREEK SMALL LETTER LAMBDA) - utf-8 encoding: 0xCE 0xBB
    # Codepoint U+2153 (VULGAR FRACTION ONE THIRD) - utf-8 encoding: 0xE2 0x85 0x93
    # Codepoint U+1D11E (MUSICAL SYMBOL G CLEF)    - utf-8 encoding: 0xF0 0x9D 0x84 0x9E
    t =    "\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8
    tbom = "\xEF\xBB\xBF\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8
    assert(tbom.remove_utf8_bom.eql?(t))
    assert("\xEF\xBB\xBFVery normal Ascii text".asutf8.remove_utf8_bom.eql?("Very normal Ascii text".asutf8))
  end
  def test_data_without_utf8_bom
    assert("".asutf8.remove_utf8_bom.eql?("".asutf8))
    # Characters in String:
    # Codepoint U+0040 (COMMERCIAL AT)             - utf-8 encoding: 0x40
    # Codepoint U+03BB (GREEK SMALL LETTER LAMBDA) - utf-8 encoding: 0xCE 0xBB
    # Codepoint U+2153 (VULGAR FRACTION ONE THIRD) - utf-8 encoding: 0xE2 0x85 0x93
    # Codepoint U+1D11E (MUSICAL SYMBOL G CLEF)    - utf-8 encoding: 0xF0 0x9D 0x84 0x9E
    s = "\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8
    assert(s.remove_utf8_bom.eql?(s))
    assert("Very normal Ascii text".asutf8.remove_utf8_bom.eql?("Very normal Ascii text".asutf8))
  end
  def test_other_encodings
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('ascii')).remove_utf8_bom.asutf8)
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('ascii-8bit')).remove_utf8_bom.asutf8)
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('us-ascii')).remove_utf8_bom.asutf8)
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('binary')).remove_utf8_bom.asutf8)
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('shift_jis')).remove_utf8_bom.asutf8)
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('sjis')).remove_utf8_bom.asutf8)
    assert_equal("\xEF\xBB\xBF\x00".asutf8, "\xEF\xBB\xBF\x00".force_encoding(Encoding.find('euc-jp')).remove_utf8_bom.asutf8)
  end
end