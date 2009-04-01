# Tests for method "check_bom"
# Wolfgang Nadasi-Donner
# Last change: 2007/11/04

require 'lib/guess_utf.rb'
require 'test/unit'

class String
  def asascii
    self.force_encoding(Encoding.find('ascii'))
  end
end

class Test_check_bom < Test::Unit::TestCase
  def test_data_with_bom
    assert_equal("utf-32be".asascii, "\x00\x00\xFE\xFF\x00\x00\x00a".asascii.check_bom)
    assert_equal("utf-32le".asascii, "\xFF\xFE\x00\x00a\x00\x00\x00".asascii.check_bom)
    assert_equal("utf-8".asascii,    "\xEF\xBB\xBFa".asascii.check_bom)
    assert_equal("utf-16be".asascii, "\xFE\xFF\x00a".asascii.check_bom)
    assert_equal("utf-16le".asascii, "\xFF\xFEa\x00".asascii.check_bom)
  end
  def test_data_without_bom
    assert_nil("\x00\x00\x00a\x00\x00\x00b".asascii.check_bom)
    assert_nil("a\x00\x00\x00b\x00\x00\x00".asascii.check_bom)
    assert_nil("abcd".asascii.check_bom)
    assert_nil("\x00a\x00b".asascii.check_bom)
    assert_nil("a\x00b\x00".asascii.check_bom)
  end
end