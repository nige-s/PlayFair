require 'spec_helper'
require_relative '../play_fair_matrix'
require_relative '../play_fair_crypter'
ENCRYPTED_MESSAGE = "BMODZBXDNABEKUDMUIXMMOUVIF"
MESSAGE = "HIDETHEGOLDINTHETREXESTUMP"
KEYWORD = "Playfair example"

describe PlayFairMatrix do
 grid ={A: ['P','L','A','Y','F'],
        B: ['R','I','E','X','M'],
        C: ['B','C','D','G','H'],
        D: ['K','N','O','Q','S'],
        E: ['T','U','V','W','Z']}

 key_grid ={A: ['P','L','A','Y','F'],
            B: ['I','R','E','X','M'],
            C: ['B','C','D','G','H'],
            D: ['K','N','O','Q','S'],
            E: ['T','U','V','W','Z']}

 context "On start up" do
 
   it "should build a default grid" do
    test_matrix = subject.build_matrix
    expect(test_matrix).to eq(grid)
  end

  it "should build a custom grid from keyword" do
    test_matrix = subject.build_matrix(keyword: KEYWORD)
    expect(test_matrix).to eq(key_grid)
  end
 end
end

describe Alphabet do
let(:alphabet) {Alphabet.new(keyword: KEYWORD)}
 
  it "should mark used characters as true" do
    expect(alphabet.is_char_valid?('e')).to be_falsey
  end
  it "should mark letters used in the keyword as invalid" do
    expect(alphabet.is_char_valid?('p')).to be_falsey
  end
end

describe PlayFairCrypter do
  matrix = PlayFairMatrix.new(keyword: KEYWORD)
  let(:play_fair) {PlayFairCrypter.new(matrix: matrix)}

context "When encrypting a message" do
  it "should return a correctly formatted message encrypted using PlayFair cypher" do
    encrypted_message = play_fair.encrypt(message: MESSAGE)
    expect(encrypted_message).to eq(ENCRYPTED_MESSAGE)
  end
end
end

describe PlayFairCrypter do
  matrix = PlayFairMatrix.new(keyword: KEYWORD)
  let(:play_fair) {PlayFairCrypter.new(matrix: matrix)}

  context "when decrypting a message" do
    it "should decrypt using PlayFair cypher" do
      decrypted_message = play_fair.decrypt(message: ENCRYPTED_MESSAGE)
      expect(decrypted_message).to eq(MESSAGE)
    end
  end
end
