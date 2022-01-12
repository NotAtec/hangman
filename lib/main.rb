# frozen_string_literal: true

require 'pry-byebug'

# Module with methods to manage loading & creating rounds
module RoundManagement
  def load_round; end

  def new_round
    Round.new
  end

  def save_round; end
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
  attr_accessor :wrong_guesses, :incorrect_letters

  def initialize
    @word = grab_word
    @word_array = @word.split('')
    @guessed_word = Array.new(@word_array.length, "_")
    p @word
    @wrong_guesses = 10
    @incorrect_letters = []
    @letters = []
  end

  def letter_included?(letter)
    @letters << letter
    @word_array.include?(letter)
  end

  def show_position(letter)
    positions = correct_positions(letter)
    positions.each do |pos|
      @guessed_word[pos] = @word_array[pos]
    end
  end

  def won?
    @guessed_word == @word_array
  end

  private

  def grab_word
    loop do
      sample = File.readlines('5desk.txt').sample.chomp
      next if sample.length < 5 || sample.length > 12

      return sample
    end
  end

  def correct_positions(letter)
    @word_array.each_index.select{|i| @word_array[i] == letter}
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
    main_loop ? game_won : game_lost
  end

  private

  def main_loop
    until @round.wrong_guesses.zero?
      return true if @round.won?

      guess = valid_player_letter
      next if guess.nil?
      next unless included?(guess)

      @round.show_position(guess)
    end
    false
  end

  def included?(guess)
    return true if @round.letter_included?(guess)

    @round.wrong_guesses -= 1
    @round.incorrect_letters << guess
  end
end

def load?
  puts 'Do you want to load a previously saved round? (y/n)'
  gets.downcase.chomp == 'y'
end

game = Game.new(load?)
game.play
