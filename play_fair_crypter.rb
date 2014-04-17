require_relative "play_fair_matrix"
class PlayFairCrypter

  def initialize(options={})
    @matrix = options[:matrix]
    @rules = {:column => 1, :row => 2, :rectangle => 3}
  end

  def encrypt(options={})
    encrypted_message = ""
    message = options[:message]
    if message
      prepared_message = prepare_message(message: message)
      prepared_message.each do |char_pair|
        char_locations = @matrix.chars_matrix_location(char_pair: char_pair)
        rule = detect_rule(chars_locale: char_locations)
        encrypted_message << crypt_chars(chars_locale: char_locations, rule: rule, cryption: :encrypt)
      end
    end
    encrypted_message
  end
  
  def decrypt(options={})
    
    decrypted_message = ""
    message = options[:message]
    if message
      prepared_message = message.upcase.scan(/../)
      prepared_message.each do |char_pair|
        char_locations = @matrix.chars_matrix_location(char_pair: char_pair)
	rule = detect_rule(chars_locale: char_locations)
        decrypted_message << crypt_chars(chars_locale: char_locations, rule: rule, cryption: :decrypt)
      end
    end
    decrypted_message
  end

  private

  def crypt_chars(options={})
    crypter = options[:cryption]
    chars_location= options[:chars_locale]
    rule = options[:rule] 
    encrypted_pair = ""
     chars_location.each do |key, val_array|
       case rule
         when @rules[:row]
	   if crypter == :encrypt
	     index = 0
	     index = chars_location[key][:index] + 1 unless  chars_location[key][:index] == 4
	   else
	     index = 4
	     index = chars_location[key][:index] - 1 unless  chars_location[key][:index] == 0
	   end
           encrypted_pair << @matrix.char_from_index(row: val_array[:row], column: index)
	  
	 when @rules[:column]
	   if crypter == :encrypt
	     symbol = PlayFairMatrix.next_row_symbol(current_row: val_array[:row])
	   else
	     symbol = PlayFairMatrix.previous_row_symbol(current_row: val_array[:row])
	   end

	   encrypted_pair << @matrix.char_from_index(row: symbol, column: chars_location[key][:index])
           
	 end
     end
     if rule == @rules[:rectangle]
      
       char1_key = chars_location[:char1][:row]
       char2_key = chars_location[:char2][:row]

       char1_index = chars_location[:char1][:index]
       char2_index = chars_location[:char2][:index]

       encrypted_pair << @matrix.char_from_index(row: char1_key, column: char2_index)
       encrypted_pair << @matrix.char_from_index(row: char2_key, column: char1_index)
     end
     encrypted_pair
  end

   # @rules = {:column => 1, :row => 2, :rectangle => 3}
  private
  def detect_rule(options={})
    char_locations = options[:chars_locale]

    if char_locations[:char1][:row] == char_locations[:char2][:row]
      @rules[:row]
    elsif  char_locations[:char1][:index] ==  char_locations[:char2][:index]
      @rules[:column]
    else
      @rules[:rectangle]
    end
  end

  private

  def prepare_message(options={})
    p_msg = options[:message].gsub(/\s+/,"").split(//)
    prepared_message = ""
    prev_letter = ""
    p_msg.each do |letter|
      if letter == prev_letter
        prepared_message << 'X'
      end
    prev_letter = letter
    prepared_message << letter
    end
    prepared_message << 'X' unless prepared_message.length % 2 == 0
    configured_message = prepared_message.upcase.scan(/../)
  end

end
