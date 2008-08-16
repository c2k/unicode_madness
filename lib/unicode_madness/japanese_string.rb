class JapaneseString < UnicodeString
  # A string that can be used in a regular expression character class to match
  # any kanji character. (Example: <tt>/[#{KANJI_CLASS}]/</tt>)
  KANJI_CLASS =
    "#{UCSCodepoint.new(0x4e00)}-#{UCSCodepoint.new(0x9fbf)}" +
    "#{UCSCodepoint.new(0x3400)}-#{UCSCodepoint.new(0x4dbf)}" +
    "#{UCSCodepoint.new(0x20000)}-#{UCSCodepoint.new(0x2a6df)}"
  
  # A string that can be used in a regular expression character class to match
  # any katakana character. (Example: <tt>/[#{KATAKANA_CLASS}]/</tt>)
  KATAKANA_CLASS = "#{UCSCodepoint.new(0x30a2)}-#{UCSCodepoint.new(0x30ff)}"
  
  # A string that can be used in a regular expression character class to match
  # any hiragana or katakana character. (Example: <tt>/[#{KANA_CLASS}]/</tt>)
  KANA_CLASS =
    "#{UCSCodepoint.new(0x3040)}-#{UCSCodepoint.new(0x30ff)}" +
    "#{UCSCodepoint.new(0x31f0)}-#{UCSCodepoint.new(0x31ff)}"
  
  # Table for converting katakana to their equivalent hiragana.
  KATAKANA_TO_HIRAGANA = {
    'ア' => 'あ', 'イ' => 'い', 'ウ' => 'う', 'エ' => 'え', 'オ' => 'お', 'カ' => 'か',
    'キ' => 'き', 'ク' => 'く', 'ケ' => 'け', 'コ' => 'こ', 'サ' => 'さ', 'シ' => 'し',
    'ス' => 'す', 'セ' => 'せ', 'ソ' => 'そ', 'タ' => 'た', 'チ' => 'ち', 'ツ' => 'つ',
    'テ' => 'て', 'ト' => 'と', 'ナ' => 'な', 'ニ' => 'に', 'ヌ' => 'ぬ', 'ネ' => 'ね',
    'ノ' => 'の', 'ハ' => 'は', 'ヒ' => 'ひ', 'フ' => 'ふ', 'ヘ' => 'へ', 'ホ' => 'ほ',
    'マ' => 'ま', 'ミ' => 'み', 'ム' => 'む', 'メ' => 'め', 'モ' => 'も', 'ヤ' => 'や',
    'ユ' => 'ゆ', 'ヨ' => 'よ', 'ラ' => 'ら', 'リ' => 'り', 'ル' => 'る', 'レ' => 'れ',
    'ロ' => 'ろ', 'ワ' => 'わ', 'ヰ' => 'ゐ', 'ヱ' => 'ゑ', 'ヲ' => 'を', 'ン' => 'ん',
    'ガ' => 'が', 'ギ' => 'ぎ', 'グ' => 'ぐ', 'ゲ' => 'げ', 'ゴ' => 'ご', 'ザ' => 'ざ',
    'ジ' => 'じ', 'ズ' => 'ず', 'ゼ' => 'ぜ', 'ゾ' => 'ぞ', 'ダ' => 'だ', 'ヂ' => 'ぢ',
    'ヅ' => 'づ', 'デ' => 'で', 'ド' => 'ど', 'バ' => 'ば', 'ビ' => 'び', 'ブ' => 'ぶ',
    'ベ' => 'べ', 'ボ' => 'ぼ', 'パ' => 'ぱ', 'ピ' => 'ぴ', 'プ' => 'ぷ', 'ペ' => 'ぺ',
    'ポ' => 'ぽ', 'ァ' => 'ぁ', 'ィ' => 'ぃ', 'ゥ' => 'ぅ', 'ェ' => 'ぇ', 'ォ' => 'ぉ',
    'ャ' => 'ゃ', 'ュ' => 'ゅ', 'ョ' => 'ょ', 'ッ' => 'っ'
  }
  
  # Table for converting voiced hiragana and katakana to their unvoiced forms.
  UNVOICED_KANA = {
    'が' => 'か', 'ぎ' => 'き', 'ぐ' => 'く', 'げ' => 'け', 'ご' => 'こ', 'ざ' => 'さ',
    'じ' => 'し', 'ず' => 'す', 'ぜ' => 'せ', 'ぞ' => 'そ', 'だ' => 'た', 'ぢ' => 'ち',
    'づ' => 'つ', 'で' => 'て', 'ど' => 'と', 'ば' => 'は', 'び' => 'ひ', 'ぶ' => 'ふ',
    'べ' => 'へ', 'ぼ' => 'ほ', 'ぱ' => 'は', 'ぴ' => 'ひ', 'ぷ' => 'ふ', 'ぺ' => 'へ',
    'ぽ' => 'ほ', 'ヴ' => 'ウ', 'ガ' => 'カ', 'ギ' => 'キ', 'グ' => 'ク', 'ゲ' => 'ケ',
    'ゴ' => 'コ', 'ザ' => 'サ', 'ジ' => 'シ', 'ズ' => 'ス', 'ゼ' => 'セ', 'ゾ' => 'ソ',
    'ダ' => 'タ', 'ヂ' => 'チ', 'ヅ' => 'ツ', 'デ' => 'テ', 'ド' => 'ト', 'バ' => 'ハ',
    'ビ' => 'ヒ', 'ブ' => 'フ', 'ベ' => 'ヘ', 'ボ' => 'ホ', 'パ' => 'ハ', 'ピ' => 'ヒ',
    'プ' => 'フ', 'ペ' => 'ヘ', 'ポ' => 'ホ'
  }
  
  # Table for converting unvoiced hiragana and katakana to their voiced forms.
  VOICED_KANA = {
    'か' => 'が', 'き' => 'ぎ', 'く' => 'ぐ', 'け' => 'げ', 'こ' => 'ご', 'さ' => 'ざ',
    'し' => 'じ', 'す' => 'ず', 'せ' => 'ぜ', 'そ' => 'ぞ', 'た' => 'だ', 'ち' => 'ぢ',
    'つ' => 'づ', 'て' => 'で', 'と' => 'ど', 'は' => 'ば', 'ひ' => 'び', 'ふ' => 'ぶ',
    'へ' => 'べ', 'ほ' => 'ぼ', 'は' => 'ぱ', 'ひ' => 'ぴ', 'ふ' => 'ぷ', 'へ' => 'ぺ',
    'ほ' => 'ぽ', 'ウ' => 'ヴ', 'カ' => 'ガ', 'キ' => 'ギ', 'ク' => 'グ', 'ケ' => 'ゲ',
    'コ' => 'ゴ', 'サ' => 'ザ', 'シ' => 'ジ', 'ス' => 'ズ', 'セ' => 'ゼ', 'ソ' => 'ゾ',
    'タ' => 'ダ', 'チ' => 'ヂ', 'ツ' => 'ヅ', 'テ' => 'デ', 'ト' => 'ド', 'ハ' => 'バ',
    'ヒ' => 'ビ', 'フ' => 'ブ', 'ヘ' => 'ベ', 'ホ' => 'ボ', 'ハ' => 'パ', 'ヒ' => 'ピ',
    'フ' => 'プ', 'ヘ' => 'ペ', 'ホ' => 'ポ'
  }
  
  # Maps kana to their romanized equivalents. Also maps full-width Latin
  # characters to their ASCII equivalents.
  KANA_ROMAJI_MAP = {
  	"あ" => "a", "い" => "i", "う" => "u", "え" => "e", "お" => "o", "か" => "ka",
  	"き" => "ki", "く" => "ku", "け" => "ke", "こ" => "ko", "さ" => "sa",
  	"し" => "shi", "す" => "su", "せ" => "se", "そ" => "so", "た" => "ta",
  	"ち" => "chi", "つ" => "tsu", "て" => "te", "と" => "to", "な" => "na",
  	"に" => "ni", "ぬ" => "nu", "ね" => "ne", "の" => "no", "は" => "ha",
  	"ひ" => "hi", "ふ" => "fu", "へ" => "he", "ほ" => "ho", "ま" => "ma",
  	"み" => "mi", "む" => "mu", "め" => "me", "も" => "mo", "や" => "ya",
  	"ゆ" => "yu", "よ" => "yo", "ら" => "ra", "り" => "ri", "る" => "ru",
  	"れ" => "re", "ろ" => "ro", "わ" => "wa", "ゐ" => "wi", "ゑ" => "we",
  	"を" => "wo", "ん" => "n", "が" => "ga", "ぎ" => "gi", "ぐ" => "gu",
  	"げ" => "ge", "ご" => "go", "ざ" => "za", "じ" => "ji", "ず" => "zu",
  	"ぜ" => "ze", "ぞ" => "zo", "だ" => "da", "ぢ" => "ji", "づ" => "zu",
  	"で" => "de", "ど" => "do", "ば" => "ba", "び" => "bi", "ぶ" => "bu",
  	"べ" => "be", "ぼ" => "bo", "ぱ" => "pa", "ぴ" => "pi", "ぷ" => "pu",
  	"ぺ" => "pe", "ぽ" => "po", "ア" => "a", "イ" => "i", "ウ" => "u", "エ" => "e",
  	"オ" => "o", "カ" => "ka", "キ" => "ki", "ク" => "ku", "ケ" => "ke",
  	"コ" => "ko", "サ" => "sa", "シ" => "shi", "ス" => "su", "セ" => "se",
  	"ソ" => "so", "タ" => "ta", "チ" => "chi", "ツ" => "tsu", "テ" => "te",
  	"ト" => "to", "ナ" => "na", "ニ" => "ni", "ヌ" => "nu", "ネ" => "ne",
  	"ノ" => "no", "ハ" => "ha", "ヒ" => "hi", "フ" => "fu", "ヘ" => "he",
  	"ホ" => "ho", "マ" => "ma", "ミ" => "mi", "ム" => "mu", "メ" => "me",
  	"モ" => "mo", "ヤ" => "ya", "ユ" => "yu", "ヨ" => "yo", "ラ" => "ra",
  	"リ" => "ri", "ル" => "ru", "レ" => "re", "ロ" => "ro", "ワ" => "wa",
  	"ヰ" => "wi", "ヱ" => "we", "ヲ" => "wo", "ン" => "n", "ガ" => "ga",
  	"ギ" => "gi", "グ" => "gu", "ゲ" => "ge", "ゴ" => "go", "ザ" => "za",
  	"ジ" => "ji", "ズ" => "zu", "ゼ" => "ze", "ゾ" => "zo", "ダ" => "da",
  	"ヂ" => "ji", "ヅ" => "zu", "デ" => "de", "ド" => "do", "バ" => "ba",
  	"ビ" => "bi", "ブ" => "bu", "ベ" => "be", "ボ" => "bo", "パ" => "pa",
  	"ピ" => "pi", "プ" => "pu", "ペ" => "pe", "ポ" => "po", "ヴ" => "vu",
  	"・" => " ", "０" => "0", "１" => "1", "２" => "2", "３" => "3", "４" => "4",
  	"５" => "5", "６" => "6", "７" => "7", "８" => "8", "９" => "9", "！" => "!",
  	"＂" => "\"", "＃" => "#", "＄" => "\$", "％" => "%", "＆" => "&", "＇" => "'",
  	"（" => "(", "）" => ")", "＊" => "*", "＋" => "+", "，" => ".", "－" => "-",
  	"．" => ".", "／" => "/", "：" => ":", "；" => ";", "＜" => "<", "＝" => "=",
  	"＞" => ">", "？" => "?", "＠" => "\@", "Ａ" => "A", "Ｂ" => "B", "Ｃ" => "C",
  	"Ｄ" => "D", "Ｅ" => "E", "Ｆ" => "F", "Ｇ" => "G", "Ｈ" => "H", "Ｉ" => "I",
  	"Ｊ" => "J", "Ｋ" => "K", "Ｌ" => "L", "Ｍ" => "M", "Ｎ" => "N", "Ｏ" => "O",
  	"Ｐ" => "P", "Ｑ" => "Q", "Ｒ" => "R", "Ｓ" => "S", "Ｔ" => "T", "Ｕ" => "U",
  	"Ｖ" => "V", "Ｗ" => "W", "Ｘ" => "X", "Ｙ" => "Y", "Ｚ" => "Z", "［" => "[",
  	"＼" => "\\", "］" => "]", "＾" => "^", "＿" => "_", "｀" => "`", "ａ" => "a",
  	"ｂ" => "b", "ｃ" => "c", "ｄ" => "d", "ｅ" => "e", "ｆ" => "f", "ｇ" => "g",
  	"ｈ" => "h", "ｉ" => "i", "ｊ" => "j", "ｋ" => "k", "ｌ" => "l", "ｍ" => "m",
  	"ｎ" => "n", "ｏ" => "o", "ｐ" => "p", "ｑ" => "q", "ｒ" => "r", "ｓ" => "s",
  	"ｔ" => "t", "ｕ" => "u", "ｖ" => "v", "ｗ" => "w", "ｘ" => "x", "ｙ" => "y",
  	"ｚ" => "z", "｛" => "{", "｜" => "|", "｝" => "}", "〜" => "-"
  }
  
  # Returns a new string with this string's katakana replaced with equivalent
  # hiragana.
  def to_hiragana
    new_str = ''
    split('').each do |ch|
      if Unicode::KATAKANA_TO_HIRAGANA.has_key?(ch)
        new_str += Unicode::KATAKANA_TO_HIRAGANA[ch]
      else
        new_str += ch
      end
    end
    new_str
  end
  
  # Returns a new string with this string's voiced hiragana and katakana
  # replaced with their unvoiced forms.
  def unvoice_kana
    new_str = ''
    split('').each do |ch|
      if Unicode::UNVOICED_KANA.has_key?(ch)
        new_str += Unicode::UNVOICED_KANA[ch]
      else
        new_str += ch
      end
    end
    new_str
  end
  
  # Returns a new string with this string's unvoiced hiragana and katakana
  # replaced with their voiced forms.
  def voice_kana
    new_str = ''
    split('').each do |ch|
      if Unicode::VOICED_KANA.has_key?(ch)
        new_str += Unicode::VOICED_KANA[ch]
      else
        new_str += ch
      end
    end
    new_str
  end
  
  # Creates a new string by romanizing the kana in this string. Full-width
  # Latin characters are also converted to their ASCII equivalents. If
  # +warnings+ is true (the default), a message is printed on +STDERR+ if an
  # un-romanizable character is encountered.
  def romanize(warnings = true)
  	romanized = String.new(self)
    
  	# Convert dipthongs. This gsub-mania is probably insanely inefficient.
  	romanized.gsub!('きゃ', 'kya'); romanized.gsub!('キャ', 'kya')
  	romanized.gsub!('きゅ', 'kyu'); romanized.gsub!('キュ', 'kyu')
  	romanized.gsub!('きょ', 'kyo'); romanized.gsub!('キョ', 'kyo')
    romanized.gsub!('しゃ', 'sha'); romanized.gsub!('シャ', 'sha')
  	romanized.gsub!('しゅ', 'shu'); romanized.gsub!('シュ', 'shu')
  	romanized.gsub!('しぇ', 'she'); romanized.gsub!('シェ', 'she')
  	romanized.gsub!('しょ', 'sho'); romanized.gsub!('ショ', 'sho')
    romanized.gsub!('ちゃ', 'cha'); romanized.gsub!('チャ', 'cha')
  	romanized.gsub!('ちゅ', 'chu'); romanized.gsub!('チュ', 'chu')
  	romanized.gsub!('ちょ', 'cho'); romanized.gsub!('チョ', 'cho')
    romanized.gsub!('にゃ', 'nya'); romanized.gsub!('ニャ', 'nya')
  	romanized.gsub!('にゅ', 'nyu'); romanized.gsub!('ニュ', 'nyu')
  	romanized.gsub!('にょ', 'nyo'); romanized.gsub!('ニョ', 'nyo')
    romanized.gsub!('ひゃ', 'hya'); romanized.gsub!('ヒャ', 'hya')
  	romanized.gsub!('ひゅ', 'hyu'); romanized.gsub!('ヒュ', 'hyu')
  	romanized.gsub!('ひょ', 'hyo'); romanized.gsub!('ヒョ', 'hyo')
    romanized.gsub!('みゃ', 'mya'); romanized.gsub!('ミャ', 'mya')
  	romanized.gsub!('みゅ', 'myu'); romanized.gsub!('ミュ', 'myu')
  	romanized.gsub!('みょ', 'myo'); romanized.gsub!('ミョ', 'myo')
    romanized.gsub!('りゃ', 'rya'); romanized.gsub!('リャ', 'rya')
  	romanized.gsub!('りゅ', 'ryu'); romanized.gsub!('リュ', 'ryu')
  	romanized.gsub!('りょ', 'ryo'); romanized.gsub!('リョ', 'ryo')
    romanized.gsub!('ぎゃ', 'gya'); romanized.gsub!('ギャ', 'gya')
  	romanized.gsub!('ぎゅ', 'gyu'); romanized.gsub!('ギュ', 'gyu')
  	romanized.gsub!('ぎょ', 'gyo'); romanized.gsub!('ギョ', 'gyo')
    romanized.gsub!('じゃ', 'ja'); romanized.gsub!('ジャ', 'ja')
  	romanized.gsub!('じゅ', 'ju'); romanized.gsub!('ジュ', 'ju')
  	romanized.gsub!('じょ', 'jo'); romanized.gsub!('ジョ', 'jo')
    romanized.gsub!('ぢゃ', 'ja'); romanized.gsub!('ヂャ', 'ja')
  	romanized.gsub!('ぢゅ', 'ju'); romanized.gsub!('ヂュ', 'ju')
  	romanized.gsub!('ぢょ', 'jo'); romanized.gsub!('ヂョ', 'jo')
    romanized.gsub!('びゃ', 'bya'); romanized.gsub!('ビャ', 'bya')
  	romanized.gsub!('びゅ', 'byu'); romanized.gsub!('ビュ', 'byu')
  	romanized.gsub!('びょ', 'byo'); romanized.gsub!('ビョ', 'byo')
    romanized.gsub!('ぴゃ', 'pya'); romanized.gsub!('ピャ', 'pya')
  	romanized.gsub!('ぴゅ', 'pyu'); romanized.gsub!('ピュ', 'pyu')
  	romanized.gsub!('ぴょ', 'pyo'); romanized.gsub!('ピョ', 'pyo')
    
  	# Convert extended kana.
  	romanized.gsub!('ふぁ', 'fa'); romanized.gsub!('でぃ', 'ti')
    romanized.gsub!('イェ', 'ye'); romanized.gsub!('ウィ', 'wi')
  	romanized.gsub!('ウェ', 'we'); romanized.gsub!('ウォ', 'wo')
  	romanized.gsub!('ヴァ', 'va'); romanized.gsub!('ヴィ', 'vi')
  	romanized.gsub!('ヴゥ', 'vu'); romanized.gsub!('ヴェ', 've')
  	romanized.gsub!('ヴォ', 'vo'); romanized.gsub!('シェ', 'she')
  	romanized.gsub!('ジェ', 'je'); romanized.gsub!('チェ', 'che')
  	romanized.gsub!('ティ', 'ti'); romanized.gsub!('トゥ', 'tu')
  	romanized.gsub!('チュ', 'tyu'); romanized.gsub!('ディ', 'di')
  	romanized.gsub!('ドゥ', 'du'); romanized.gsub!('デュ', 'dyu')
  	romanized.gsub!('ツァ', 'tsa'); romanized.gsub!('ツェ', 'tse')
  	romanized.gsub!('ツォ', 'tso'); romanized.gsub!('ファ', 'fa')
  	romanized.gsub!('フィ', 'fi'); romanized.gsub!('フェ', 'fe')
  	romanized.gsub!('フォ', 'fo'); romanized.gsub!('フュ', 'fyu')
  	romanized.gsub!('スィ', 'si'); romanized.gsub!('ゲィ', 'gei')
  	romanized.gsub!('ワァ', 'waa'); romanized.gsub!('ツィ', 'tsui')
  	romanized.gsub!('シィ', 'shii'); romanized.gsub!('ウァ', 'ua')
  	romanized.gsub!('ヴュ', 'vyu'); romanized.gsub!('クォ', 'quo')
  	romanized.gsub!('テュ', 'tu'); romanized.gsub!('グィ', 'gui')
  	romanized.gsub!('クェ', 'que'); romanized.gsub!('ビィ', 'bii')
  	romanized.gsub!('ツィ', 'tsi'); romanized.gsub!('ズィ', 'zi')
  	romanized.gsub!('リィ', 'rii'); romanized.gsub!('テュ', 'tu')
    
  	# Do simple conversions.
  	chars = romanized.split('')
  	chars.each_with_index do |ch,i|
  		chars[i] = KANA_ROMAJI_MAP[ch] if KANA_ROMAJI_MAP.has_key?(ch)
  		if chars[i] !~ /\A[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&\d\.\-ッっー ]+\Z/
  			STDERR.puts "Couldn't romanize #{ch} in #{self}" if warnings
  		end
  	end
  	romanized = chars.join('')
    
  	# Convert letter-doublers (small tsu and katakana dash).
  	romanized.gsub!(/[ッっ](.)/, '\1\1')
  	romanized.gsub!(/(.)ー/, '\1\1')
    
	  romanized
  end
  
  # Creates a 7-bit-safe string that can be used to sort strings containing
  # kana and/or English text.
  def kana_sort_key
  	key = ''
  	downcase.split('').each do |ch|
  		if ch =~ /[0-9]/
  			ch[0] -= 15 # produces ! through *
  		elsif ch =~ /[a-z]/
  			ch[0] -= 54 # produces + through E
  		elsif KANA_SORT_MAP.has_key?(ch)
  			ch = KANA_SORT_MAP[ch]
  			if ch.kind_of?(Numeric)
  				tmp = ' '
  				tmp[0] = ch + 70
  				ch = tmp
  			else
  				redo
  			end
  		else
  			next
  		end
  		key += ch
  	end
  	key
  end

private
  
  # Table for creating kana sort keys. See kana_sort_key.
  KANA_SORT_MAP = {
  	"あ" => 0, "い" => 1, "う" => 2, "え" => 3, "お" => 4, "か" => 5, "き" => 6,
  	"く" => 7, "け" => 8, "こ" => 9, "さ" => 10, "し" => 11, "す" => 12, "せ" => 13,
  	"そ" => 14, "た" => 15, "ち" => 16, "つ" => 17, "て" => 18, "と" => 19,
  	"な" => 20, "に" => 21, "ぬ" => 22, "ね" => 23, "の" => 24, "は" => 25,
  	"ひ" => 26, "ふ" => 27, "へ" => 28, "ほ" => 29, "ま" => 30, "み" => 31,
  	"む" => 32, "め" => 33, "も" => 34, "や" => 35, "ゆ" => 36, "よ" => 37,
  	"ら" => 38, "り" => 39, "る" => 40, "れ" => 41, "ろ" => 42, "わ" => 43,
  	"ゐ" => 44, "ゑ" => 45, "を" => 46, "ん" => 47, "が" => 5, "ぎ" => 6, "ぐ" => 7,
  	"げ" => 8, "ご" => 9, "ざ" => 10, "じ" => 11, "ず" => 12, "ぜ" => 13, "ぞ" => 14,
  	"だ" => 15, "ぢ" => 16, "づ" => 17, "で" => 18, "ど" => 19, "ば" => 25,
  	"び" => 26, "ぶ" => 27, "べ" => 28, "ぼ" => 29, "ぱ" => 25, "ぴ" => 26,
  	"ぷ" => 27, "ぺ" => 28, "ぽ" => 29, "ア" => 0, "イ" => 1, "ウ" => 2, "エ" => 3,
  	"オ" => 4, "カ" => 5, "キ" => 6, "ク" => 7, "ケ" => 8, "コ" => 9, "サ" => 10,
  	"シ" => 11, "ス" => 12, "セ" => 13, "ソ" => 14, "タ" => 15, "チ" => 16,
  	"ツ" => 17, "テ" => 18, "ト" => 19, "ナ" => 20, "ニ" => 21, "ヌ" => 22,
  	"ネ" => 23, "ノ" => 24, "ハ" => 25, "ヒ" => 26, "フ" => 27, "ヘ" => 28,
  	"ホ" => 29, "マ" => 30, "ミ" => 31, "ム" => 32, "メ" => 33, "モ" => 34,
  	"ヤ" => 35, "ユ" => 36, "ヨ" => 37, "ラ" => 38, "リ" => 39, "ル" => 40,
  	"レ" => 41, "ロ" => 42, "ワ" => 43, "ヰ" => 44, "ヱ" => 45, "ヲ" => 46,
  	"ン" => 47, "ガ" => 5, "ギ" => 6, "グ" => 7, "ゲ" => 8, "ゴ" => 9, "ザ" => 10,
  	"ジ" => 11, "ズ" => 12, "ゼ" => 13, "ゾ" => 14, "ダ" => 15, "ヂ" => 16,
  	"ヅ" => 17, "デ" => 18, "ド" => 19, "バ" => 25, "ビ" => 26, "ブ" => 27,
  	"ベ" => 28, "ボ" => 29, "パ" => 25, "ピ" => 26, "プ" => 27, "ペ" => 28,
  	"ポ" => 29, "ヴ" => 2, "０" => "0", "１" => "1", "２" => "2", "３" => "3",
  	"４" => "4", "５" => "5", "６" => "6", "７" => "7", "８" => "8", "９" => "9",
  	"Ａ" => "a", "Ｂ" => "b", "Ｃ" => "c", "Ｄ" => "d", "Ｅ" => "e", "Ｆ" => "f",
  	"Ｇ" => "g", "Ｈ" => "h", "Ｉ" => "i", "Ｊ" => "j", "Ｋ" => "k", "Ｌ" => "l",
  	"Ｍ" => "m", "Ｎ" => "n", "Ｏ" => "o", "Ｐ" => "p", "Ｑ" => "q", "Ｒ" => "r",
  	"Ｓ" => "s", "Ｔ" => "t", "Ｕ" => "u", "Ｖ" => "v", "Ｗ" => "w", "Ｘ" => "x",
  	"Ｙ" => "y", "Ｚ" => "z", "ａ" => "a", "ｂ" => "b", "ｃ" => "c", "ｄ" => "d",
  	"ｅ" => "e", "ｆ" => "f", "ｇ" => "g", "ｈ" => "h", "ｉ" => "i", "ｊ" => "j",
  	"ｋ" => "k", "ｌ" => "l", "ｍ" => "m", "ｎ" => "n", "ｏ" => "o", "ｐ" => "p",
  	"ｑ" => "q", "ｒ" => "r", "ｓ" => "s", "ｔ" => "t", "ｕ" => "u", "ｖ" => "v",
  	"ｗ" => "w", "ｘ" => "x", "ｙ" => "y", "ｚ" => "z"
  }
end
