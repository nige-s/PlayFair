require 'spec_helper'
require_relative '../play_fair'

describe PlayFair do
 grid ={A: ['P','L','A','Y','F'],
        B: ['R','I','E','X','M'],
        C: ['B','C','D','G','H'],
        D: ['K','N','O','Q','S'],
        E: ['T','U','V','W','Z']}

 key_grid ={A: ['E','N','C','R','Y'],
            B: ['P','T','I','O','A'],
            C: ['B','D','F','G','H'],
            D: ['J','K','L','M','Q'],
            E: ['S','U','V','W','X']}
 
 it "should build a default grid" do
    test_grid = subject.build_grid
    test_grid.should == grid
  end

 it "should build a custom grid from keyword" do
   k_grid = subject.build_grid(keyword: "ENCRYPTION")
   k_grid.should == key_grid
 end
end

describe AlphabetTracker do
let(:alphabet) {AlphabetTracker.new(keyword: "ENCRYPTION")}
 
it "should mark used characters as true" do
    alphabet.is_char_valid?('e').should be_false
  end
end
