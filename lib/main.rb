# frozen_string_literal: true

require 'pry-byebug'

module RoundManagement
  def load_round

  end

  def new_round
    Round.new()
  end
end

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

class Round
  attr_reader :letters, :word

  def initialize
    @word = grab_word
    @wrong_guesses = 10
    @incorrect_letters = []
    @letters = []
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

class Game
  include RoundManagement
  include PlayerInput

  def initialize(load)
    @round = load ? load_round : new_round
  end
end