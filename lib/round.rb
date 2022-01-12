# frozen_string_literal: true

# Round class includes all variables that can be saved & (Will) includes method to load a round from file on disk.
class Round
  include RoundManagement
  attr_reader :letters, :word, :guessed_word
  attr_accessor :wrong_guesses, :incorrect_letters

  def initialize
    @word = grab_word
    @word_array = @word.split('')
    @guessed_word = Array.new(@word_array.length, '_')
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

  def correct_positions(letter)
    @word_array.each_index.select { |i| @word_array[i] == letter }
  end
end
