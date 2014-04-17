require_relative "play_fair_matrix"
require_relative "play_fair_crypter"

class PlayFairCypher
DEF_KEYWORD = "none"
NOT_ENCRYPTED = "Not Encrypted"

  def initialize(options={})
    @keyword = options[:keyword] || DEF_KEYWORD
    @matrix = PlayFairMatrix.new(keyword: @keyword)
    @crypter = PlayFairCrypter.new(matrix: @matrix)    
  end

  def encrypt(options={})
    if options[:message]
      message = options[:message]
      output = @crypter.encrypt(message: message)
    else
     output = NOT_ENCRYPTED
    end
  end

  def decrypt(options={})
    if options[:message]
      message = options[:message]
      output = @crypter.decrypt(message: message)
    else
     output = NOT_ENCRYPTED
    end

  end
end

