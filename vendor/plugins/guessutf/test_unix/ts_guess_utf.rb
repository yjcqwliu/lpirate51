# Test suite for all tests on "guess_utf.rb"
# Wolfgang Nadasi-Donner
# Last change: 2007/11/04

require 'test/unit'
require 'test/tc_check_bom'
require 'test/tc_check_utf8_encoding'
require 'test/tc_remove_utf8_bom'
require 'test/tc_remove_utf8_bom_change_self'
require 'test/tc_add_utf8_bom'
require 'test/tc_add_utf8_bom_change_self'