# DICTIONARY = Hash.new(File.read('dictionary.txt').split("\n"))
# DICTIONARY = eval(File.read('dictionary.txt'))
# p DICTIONARY

class Game
  DICTIONARY = {}
  File.open('dictionary.txt') do |file|
    file.each_line do |line|
      DICTIONARY[line.chomp] = true
    end
  end

  attr_reader :dictionary

  def initialize(players, fragment)
    @dictionary = DICTIONARY
    @players = players
    @fragment = fragment
  end

  frag = "zon"
  
  
end

g = Game.new("hi", "frag")
p g.dictionary["zoned"]