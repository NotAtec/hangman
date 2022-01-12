# frozen_string_literal: true

# Main class containing all components related to playing the (Saved) round
class Game
  include RoundManagement
  include PlayerInput

  def initialize(load)
    @round = load ? load_round : new_round
  end

  def play
    result = main_loop
    show_status
    if result
      puts "\nCongrats! You have won the game, with #{@round.wrong_guesses} incorrect guesses remaining!"
    else
      puts "\nUnfortunately, you lost! The word was: #{@round.word}"
    end
  end

  private

  def main_loop
    until @round.wrong_guesses.zero?
      return true if @round.won?

      show_status
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

  def show_status
    letter_string = @round.incorrect_letters.join(' ')
    word_string = @round.guessed_word.join(' ')

    puts "\nIncorrect Guesses Remaining: #{@round.wrong_guesses}"
    puts "Incorrect Letters: #{letter_string}"
    puts "Known Letters: #{word_string}\n"
  end
end
