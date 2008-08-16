class UnicodeString < String
  # Returns a Boolean indicating whether this character is a kanji character.
  # (This string must contain only one character.)
  def kanji?
    codepoint.kanji?
  end
  
  # Returns a Boolean indicating whether this character is a hiragana or
  # katakana character. (This string must contain only one character.)
  def kana?
    codepoint.kana?
  end
  
  # Returns a Boolean indicating whether this character is a full-width latin
  # character. (This string must contain only one character.)
  def wide_latin?
    codepoint.wide_latin?
  end
  
  # Returns the UCS codepoint of this character. (This string must contain only
  # one character.) Currently only UTF8 encoding is supported.
  def codepoint
    unless $KCODE =~ /^u/i
      raise ArgumentError, "unsupported encoding (#{$KCODE})"
    end
    unless jlength == 1
      raise RangeError, "string must be exactly one character long"
    end
    
	  case self.length
  	when 1
  	  UCSCodepoint.new(self[0])
  	when 2
  	  UCSCodepoint.new(
    	  ((self[0] & 0x1f) << 6) +
    	  (self[1] & 0x3f)
  	  )
  	when 3
  	  UCSCodepoint.new(
    	  ((self[0] & 0x0f) << 12) +
    	  ((self[1] & 0x3f) << 6) +
    	  (self[2] & 0x3f)
  	  )
  	when 4
  	  UCSCodepoint.new(
    	  ((self[0] & 0x07) << 18) +
    	  ((self[1] & 0x3f) << 12) +
    	  ((self[2] & 0x3f) << 6) +
    	  (self[3] & 0x3f)
  	  )
  	end
  end
  
  # Like index, but returns a character offset instead of a byte offset. The
  # starting offset is also in characters instead of bytes.
  def uindex(substr, uoffset = 0)
    offset = uindex_to_index(uoffset)
    index_to_uindex(index(substr, offset))
  end
  
  # Like slice, but takes a character offset and length (instead of bytes).
  # Can't handle negative lengths.
  def uslice(uoffset, ulength)
    offset = uindex_to_index(uoffset)
    substr = slice(offset, length)
    substr.split('')[0,ulength].join('')
  end
  
  # Converts a byte offset to a character offset. The byte offset must be
  # greater than or equal to zero and less than or equal to the byte length of
  # the string. Returns +nil+ if the offset is in the middle of a character.
  def index_to_uindex(byte_index)
    return nil if byte_index.nil?
    if byte_index < 0 || byte_index > length
      raise RangeError, 'index out of range'
    end
    
    chars = split('')
    char_index = 0
    chars.each do |ch|
      break if byte_index == 0
      byte_index -= ch.length
      return nil if byte_index < 0
      char_index += 1
    end
    char_index
  end
  
  # Converts a character offset to a byte offset. The character offset must be
  # greater than or equal to zero and less than or equal to the character
  # length of the string.
  def uindex_to_index(char_index)
    return nil if char_index.nil?
    if char_index < 0 || char_index > jlength
      raise RangeError, 'index out of range'
    end
    
    chars = split('')
    byte_index = 0
    char_index.times do |i|
      byte_index += chars[i].length
    end
    byte_index
  end
end
