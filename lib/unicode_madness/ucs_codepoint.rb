require 'delegate'

class UCSCodepoint < DelegateClass(Integer)
  # Returns a Boolean indicating whether this UCS codepoint represents a kanji
  # character.
  def kanji?
    (self >=  0x4e00 && self <=  0x9fbf) ||
    (self >=  0x3400 && self <=  0x4dbf) ||
    (self >= 0x20000 && self <= 0x2a6df)
  end
  
  # Returns a Boolean indicating whether this UCS codepoint represents a
  # hiragana or katakana character.
  def kana?
    (self >= 0x3040 && self <= 0x30ff) ||
    (self >= 0x31f0 && self <= 0x31ff)
  end
  
  # Returns a Boolean indicating whether this UCS codepoint represents a
  # full-width latin character.
  def wide_latin?
    self >= 0xff10 && self <= 0xff5a
  end
  
  # Returns an encoded string containing the character represented by this UCS
  # codepoint. Currently only UTF-8 encoding is supported.
  def to_s
    unless $KCODE =~ /^u/i
      raise ArgumentError, 'unrecognized encoding (only UTF-8 is supported at the moment)'
    end
    
    if self <= 0x7f
      ch = ' '
      ch[0] = to_i
    elsif self <= 0x7ff
      ch = '  '
      ch[0] = ((self & 0x7c0) >> 6) | 0xc0
      ch[1] = self & 0x3f | 0x80
    elsif self <= 0xffff
      ch = '   '
      ch[0] = ((self & 0xf000) >> 12) | 0xe0
      ch[1] = ((self & 0xfc0) >> 6) | 0x80
      ch[2] = self & 0x3f | 0x80
    else
      ch = '    '
      ch[0] = ((self & 0x1c0000) >> 18) | 0xf0
      ch[1] = ((self & 0x3f000) >> 12) | 0x80
      ch[2] = ((self & 0xfc0) >> 6) | 0x80
      ch[3] = (self & 0x3f) | 0x80
    end
    return ch
  end
  
  def inspect
    "#<#{self.class}:0x#{self.to_i.to_s(16)} #{self.to_s.inspect}>"
  end
end
