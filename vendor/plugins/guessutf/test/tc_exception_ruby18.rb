# Test for "require" of library
# Ruby 1.9 or better is required for "guess_utf"
# This file is encoded in ASCII (without BOM), because
# Ruby 1.8.n has problems with program sources containing
# a BOM.
# Wolfgang Nadasi-Donner
# Last change: 2007/11/04

require 'test/unit'

class Test_check_bom < Test::Unit::TestCase
  def test_require_guess_utf
    versions_info = RUBY_VERSION.split('.').map{|s|Integer(s)}
    if versions_info[0] < 2 && versions_info[1] < 9
      assert_raise(NotImplementedError){require 'lib/guess_utf.rb'}
    else
      assert_nothing_raised(NotImplementedError){require 'lib/guess_utf.rb'}
    end
  end
end