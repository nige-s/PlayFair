require_relative "Alphabet"

class PlayFairMatrix
  COLUMNS = 5

  def initialise(options={})
    if options[:keyword]
      keyword = options[:keyword]
      build_matrix(keyword: keyword)
    else
      build_matrix
    end
  end

  def build_matrix(options = {})
   @grid = if options[:keyword]
             build_keyword_matrix(options[:keyword])
           else
              {A: ['P','L','A','Y','F'],
               B: ['R','I','E','X','M'],
	       C: ['B','C','D','G','H'],
	       D: ['K','N','O','Q','S'],
 	       E: ['T','U','V','W','Z']}
           end
  end

  def self.previous_row_symbol(options={})
    
    case options[:current_row]
    when :A
      :E
    when :B
      :A
    when :C
      :B
    when :D
      :C
    when :E
      :D
    end
  end
  def self.next_row_symbol(options={})
    
    case options[:current_row]
    when :A
      :B
    when :B
      :C
    when :C
      :D
    when :D
      :E
    when :E
      :A
    end
  end

  private

  def build_keyword_matrix(keyword)
    keys = keyword.upcase.gsub(/\s+/,"").split(//).uniq
    num_keys = keys.length
    current_index = 0

    alphabet = Alphabet.new(keyword: keyword)
    legal_letters = Alphabet.legal_letters
    matrix = {A: [], B: [], C: [], D: [], E: []}
    matrix.each do |key, row|
      for index in 0..COLUMNS - 1
        if current_index < num_keys
         matrix[key][index] = keys[current_index]
	  current_index += 1
	else
	  searching = true
          while searching
            legal_letters.each do |v_char|
              if alphabet.is_char_valid?(v_char)
                row[index] = v_char
		searching = false
                current_index += 1
		break
	      end
	    end
	  end
	end
      end
    end
    matrix
  end
end

