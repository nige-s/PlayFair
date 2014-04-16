class PlayFairCrypter

  def initialize(options={})
    @pf_matrix = options[:matrix]
    @rules = {:column => 1, :row => 2, :rectangle => 3}
  end

  def encrypt(options={})
    encrypted_message = ""
    message = options[:message]
    if message
      prepared_message = prepare_message(message: message)
      prepared_message.each do |char_pair|
        char_locations = chars_matrix_location(char_pair: char_pair)
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
        char_locations = chars_matrix_location(char_pair: char_pair)
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
	     default_index = 0
	     default_index = chars_location[key][:index] + 1 unless  chars_location[key][:index] == 4
	   else
	     default_index = 4
	     default_index = chars_location[key][:index] - 1 unless  chars_location[key][:index] == 0
	   end
           encrypted_pair << @pf_matrix[val_array[:row]][default_index]
	  
	 when @rules[:column]
	   if crypter == :encrypt
	     default_symbol = PlayFairMatrix.next_row_symbol(current_row: val_array[:row])
	   else
	     default_symbol = PlayFairMatrix.previous_row_symbol(current_row: val_array[:row])
	   end

	   encrypted_pair << @pf_matrix[default_symbol][chars_location[key][:index]]
           
	 end
     end
     if rule == @rules[:rectangle]
      
       char1_key = chars_location[:char1][:row]
       char2_key = chars_location[:char2][:row]

       char1_index = chars_location[:char1][:index]
       char2_index = chars_location[:char2][:index]
       if crypter == :encrypt
         encrypted_pair << @pf_matrix[char1_key][char2_index]
         encrypted_pair << @pf_matrix[char2_key][char1_index]
       else
	# puts "char1_key: #{char1_key} char1_index: #{char1_index} char2_key #{char2_key} char2_index: #{char2_index}"
         encrypted_pair << @pf_matrix[char1_key][char2_index]
         encrypted_pair << @pf_matrix[char2_key][char1_index]
       end
     end
     #puts encrypted_pair
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
  def chars_matrix_location(options={})
    char_array = options[:char_pair].split(//)
    char_location = { char1: {row: :p, index: 0, encrypted: '' }, char2:  {row: :p, index: 0, encrypted: '' }}
    @pf_matrix.each do |key, val_array|
    index = 0
       val_array.each do |char|
	 if char_array[0] == char
           char_location[:char1][:row] = key
	   char_location[:char1][:index] = index 
	 end
	 if char_array[1] == char
           char_location[:char2][:row] = key
	   char_location[:char2][:index] = index 
	 end
	 index += 1
      end
    end
    char_location
  end


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
=begin
    configured_message.map! do |pair|
      temp_pair = pair.split(//)
      if pair.length == 2
      
	if temp_pair[0] == temp_pair[1]
	  temp_pair[1] = 'X'
	end
      else
	temp_pair[0] = pair
        temp_pair[1]= 'X'
      end
        pair = temp_pair.join
    end
=end
    configured_message
  end

end
