# Tests for method "add_utf8_bom"
# Wolfgang Nadasi-Donner
# Last change: 2007/11/04

require 'lib/guess_utf.rb'
require 'test/unit'

class String
  def asutf8
    self.force_encoding(Encoding.find('utf-8'))
  end
end

class Test_add_utf8_bom < Test::Unit::TestCase
  def test_utf8_data
    assert("".asutf8.add_utf8_bom.eql?("\xEF\xBB\xBF".asutf8))
    # Characters in String:
    # Codepoint U+0040 (COMMERCIAL AT)             - utf-8 encoding: 0x40
    # Codepoint U+03BB (GREEK SMALL LETTER LAMBDA) - utf-8 encoding: 0xCE 0xBB
    # Codepoint U+2153 (VULGAR FRACTION ONE THIRD) - utf-8 encoding: 0xE2 0x85 0x93
    # Codepoint U+1D11E (MUSICAL SYMBOL G CLEF)    - utf-8 encoding: 0xF0 0x9D 0x84 0x9E
    t =    "\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8
    tbom = "\xEF\xBB\xBF\x40\xCE\xBB\xE2\x85\x93\xF0\x9D\x84\x9E".asutf8
    assert(t.add_utf8_bom.eql?(tbom))
    assert("Very normal Ascii text".asutf8.add_utf8_bom.eql?("\xEF\xBB\xBFVery normal Ascii text".asutf8))
  end
  def test_other_encodings
    assert_equal("".asutf8, "".force_encoding(Encoding.find('ascii')).add_utf8_bom)
    assert_equal("".asutf8, "".force_encoding(Encoding.find('ascii-8bit')).add_utf8_bom)
    assert_equal("".asutf8, "".force_encoding(Encoding.find('us-ascii')).add_utf8_bom)
    assert_equal("".asutf8, "".force_encoding(Encoding.find('binary')).add_utf8_bom)
    assert_equal("".asutf8, "".force_encoding(Encoding.find('shift_jis')).add_utf8_bom)
    assert_equal("".asutf8, "".force_encoding(Encoding.find('sjis')).add_utf8_bom)
    assert_equal("".asutf8, "".force_encoding(Encoding.find('euc-jp')).add_utf8_bom)
  end
end