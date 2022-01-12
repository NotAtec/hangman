# frozen_string_literal: true

require 'pry-byebug'

module RoundManagement
  def load_round

  end

  def new_round
    Round.new()
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