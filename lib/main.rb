# frozen_string_literal: true

require 'pry-byebug'

# Module with methods to manage loading & creating rounds
module RoundManagement
  def load_round; end

  def new_round
    Round.new
  end
end

# Module with methods to get & validate player input
module PlayerInput
  def valid_player_letter
    puts 'Input your guess, a letter from A to Z'
    g = gets.chomp
    return nil if invalid?(g) || already_played?(g)

    g
  end

  def invalid?(guess)
    if guess.length == 1 && guess.downcase.match(/[a-z]/)
      false
    else
      puts 'Please input only 1 letter, from A to Z'
      true
    end
  end

  def already_played?(guess)
    if @round.letters.include?(guess)
      puts 'Please input a character you haven\'t guessed before'
      true
    else
      false
    end
  end
end

# Round class includes all variables that can be saved & (Will) includes method to load a round from file on disk.
class Round
  attr_reader :letters
  attr_accessor :wrong_guesses

  def initialize
    @word = grab_word
    @word_array = @word.split('')
    p @word
    @wrong_guesses = 10
    @incorrect_letters = []
    @letters = []
  end

  def letter_included?(letter)
    @word_array.include?(letter)
  end

  private

  def grab_word
    loop do
      sample = File.readlines('5desk.txt').sample.chomp
      next if sample.length < 5 || sample.length > 12

      return sample
    end
  end
end

# Main class containing all components related to playing the (Saved) round
class Game
  include RoundManagement
  include PlayerInput

  def initialize(load)
    @round = load ? load_round : new_round
  end

  def play
    until @round.wrong_guesses.zero?
      guess = valid_player_letter
      next if guess.nil?

      unless @round.letter_included?(guess)
        @round.wrong_guesses -= 1
        next
      end

      
    end
  end
end

def load?
  puts 'Do you want to load a previously saved round? (y/n)'
  gets.downcase.chomp == 'y'
end

game = Game.new(load?)
game.play
