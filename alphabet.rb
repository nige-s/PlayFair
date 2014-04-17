class Alphabet

  def initialize(options={})
    self.initialize_hash(options)  
  end

  def initialize_hash(options={})
    @alphabet ||= {'A' => true,'B' => true,'C' => true,'D' => true,'E' => true,'F' => true,
      'G' => true, 'H' => true,'K' => true,'L' => true,'M' => true,
      'N' => true, 'O' => true,'P' => true,'Q' => true,'R' => true,'S' => true,
      'T' => true, 'U' => true,'V' => true,'W' => true,'X' => true,'Y' => true, 
      'Z' => true} 
    if options[:keyword]
      key_letters = options[:keyword].upcase.split(//)
      key_letters.each {|char| @alphabet[char] = false}
    end
  end

  def is_char_valid?(char)
    char = char.upcase
    if @alphabet[char] == true
      @alphabet[char] = false
      true
    else
      false
    end
  end
  def self.legal_letters
    ['A','B','C','D','E','F',
     'G','H','K','L','M',
     'N','O','P','Q','R','S',
     'T','U','V','W','X','Y', 
     'Z']
  end
end
