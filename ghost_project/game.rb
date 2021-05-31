# Game class for ghost game
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

  def word?(fragment)
    dictionary.keys.any? { |word| word.start_with?(fragment) }
  end
end

g = Game.new('hi', 'frag')
p g.word?('zona')