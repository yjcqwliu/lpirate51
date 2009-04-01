# This is an extensions to class *String* for recognizing 
# <em>Unicode Byte Order Marks (BOM)</em>, for adding and deleting
# a <em>BOM</em> in <em>utf-8 encoded</em> String objects, and for
# checking an utf-8 encoded String object if it is a well-formed utf-8
# byte sequence according to the Unicode standard.
#
# It works only for Ruby versions greater or equal Ruby 1.9
versions_info = RUBY_VERSION.split('.').map{|s|Integer(s)}
if versions_info[0] < 2 && versions_info[1] < 9
  raise NotImplementedError, "Ruby 1.9 or better is required for 'guess_utf.rb'", caller(1)
end

# File: guess_utf.rb

# Version 1.0.0 (Last modified November, 4th, 2007)
#
# Author: Wolfgang Nadasi-Donner 
#
# License: Ruby license 
# 
# This source code is provided as is by Wolfgang Nadasi-Donner. No claims are 
# made as to fitness for any particular purpose. No warranties of any 
# kind are expressed or implied.
#
# Copyright 2007 Wolfgang Nadasi-Donner
#
# (first 'a' in 'Nadasi' is letter [LATIN SMALL LETTER A WITH ACUTE])
class String
  
  # Tests the first bytes of a String object for the occurence of one
  # of the <em>Unicode Byte Order Marks (BOM)</em>.
  # ---
  # <em>check_bom</em> has the following return values:
  #
  # <b>nil</b>::        no BOM recognized
  # 'utf-8'::    UTF-8 BOM recognized
  # 'utf-16le':: UTF-16LE BOM recognized
  # 'utf-16be':: UTF-16BE BOM recognized
  # 'utf-32le':: UTF-32LE BOM recognized (or UTF-16LE with 0x0000 after BOM)
  # 'utf-32be':: UTF-32BE BOM recognized
  def check_bom
    selfbytes = self.bytes
    comp2 = selfbytes.first(2)
    comp3 = selfbytes.first(3)
    comp4 = selfbytes.first(4)
    if    comp4.eql?([0x00, 0x00, 0xFE, 0xFF]) then return 'utf-32be'
    elsif comp4.eql?([0xFF, 0xFE, 0x00, 0x00]) then return 'utf-32le'
    elsif comp3.eql?([0xEF, 0xBB, 0xBF])       then return 'utf-8'
    elsif comp2.eql?([0xFE, 0xFF])             then return 'utf-16be'
    elsif comp2.eql?([0xFF, 0xFE])             then return 'utf-16le'
    else                                            return nil
    end
  end # check_bom
  
  # <em>remove_utf8_bom</em> returns a copy of <b>self</b> without a leading utf-8-BOM, if the encoding
  # is utf-8 and <b>self</b> starts with an utf-8-BOM. Otherwise a copy of <b>self</b> will be returned.
  #
  # The String object <b>self</b> must be a well-formed utf-8 encoded String object.
  def remove_utf8_bom
    if self.encoding.eql?(Encoding.find('utf-8')) && self.bytes.first(3).eql?([0xEF, 0xBB, 0xBF])
      self.slice(1..-1)
    else
      self[0..-1]
    end
  end # remove_utf8_bom
  
  # <em>remove_utf8_bom!</em> removes a leading _utf-8-BOM_ from <b>self</b>, if the encoding
  # is utf-8 and <b>self</b> starts with an utf-8-BOM.
  #
  # If an utf-8-BOM was removed, it is the return value. Otherwise <b>nil</b> will be
  # returned.
  #
  # The String object <b>self</b> must be a well-formed utf-8 encoded String object.
  def remove_utf8_bom!
    if self.encoding.eql?(Encoding.find('utf-8')) && self.bytes.first(3).eql?([0xEF, 0xBB, 0xBF])
      self.slice!(0,1)
    else
      nil
    end
  end # remove_utf8_bom!
  
  # <em>add_utf8_bom</em> returns a copy of <b>self</b> with an added utf-8-BOM, if the encoding
  # is utf-8. Otherwise an unmodified copy of <b>self</b> will be returned.
  #
  # The String object <b>self</b> must be a well-formed utf-8 encoded String object.
  def add_utf8_bom
    if self.encoding.eql?(Encoding.find('utf-8'))
      "\xEF\xBB\xBF".force_encoding(Encoding.find('utf-8')) + self
    else
      self[0..-1]
    end
  end # add_utf8_bom
  
  # <em>add_utf8_bom!</em> returns <b>self</b> with an added utf-8-BOM, if the encoding
  # is utf-8. Otherwise <b>nil</b> will be returned.
  #
  # The String object <b>self</b> must be a well-formed utf-8 encoded String object.
  def add_utf8_bom!
    if self.encoding.eql?(Encoding.find('utf-8'))
      self.insert(0, "\xEF\xBB\xBF".force_encoding(Encoding.find('utf-8')))
    else
      nil
    end
  end # add_utf8_bom!

  # <em>check_utf8_encoding</em> checks <b>self</b> completely on basis of
  # the identical Tables <i>Table 3-7. Well-Formed UTF-8 Byte Sequences</i>
  # (Unicode 5.0), or <i>Table 3-6. Well-Formed UTF-8 Byte Sequences</i>
  # (Unicode 4.0).
  #
  # The method returns <b>nil</b> if the encoding of <b>self</b> isn't
  # utf-8 or if the contents of <b>self</b> doesn't follow the rules
  # described in the Unicode tables.
  #
  # If the check succeeds, the
  # number of recognized utf-8 characters (Unicode codepoints)
  # will be returned (this may include a BOM if present).  
  def check_utf8_encoding
    return nil if self.encoding != Encoding.find('utf-8')
    state = :s0
    n_of_chars = 0
    self.bytes.each do |byte|
      case state
        when :s0
          n_of_chars += 1
          if (0x00..0x7F).include?(byte) then state = :s0
          elsif (0xC2..0xDF).include?(byte) then state = :s1
          elsif 0xE0 == byte then state = :s2
          elsif (0xE1..0xEC).include?(byte) || (0xEE..0xEF).include?(byte) then state = :s3
          elsif 0xED == byte then state = :s4
          elsif 0xF0 == byte then state = :s5
          elsif (0xF1..0xF3).include?(byte) then state = :s7
          elsif 0xF4 == byte then state = :s8
          else return nil end
        when :s1
          if (0x80..0xBF).include?(byte) then state = :s0 
          else return nil end
        when :s2
          if  (0xA0..0xBF).include?(byte) then state = :s1
          else return nil end
        when :s3
          if  (0x80..0xBF).include?(byte) then state = :s1
          else return nil end
        when :s4
          if  (0x80..0x9F).include?(byte) then state = :s1
          else return nil end
        when :s5
          if  (0x90..0xBF).include?(byte) then state = :s6
          else return nil end
        when :s6
          if  (0x80..0xBF).include?(byte) then state = :s1
          else return nil end
        when :s7
          if  (0x80..0xBF).include?(byte) then state = :s6
          else return nil end
        when :s8
          if  (0x80..0x8F).include?(byte) then state = :s6
          else return nil end
      end # case
    end # self.bytes.each
    if state == :s0 then return n_of_chars
    else return nil end
  end # check_utf8_encoding

end # String