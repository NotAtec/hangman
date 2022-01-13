# frozen_string_literal: true

# Main class containing all components related to playing the (Saved) round
class Game
  include RoundManagement
  include PlayerInput

  def initialize(load)
    load ? load_round : new_round
  end

  def play
    result = main_loop
    show_status
    if result
      puts "\nCongrats! You have won the game, with #{@round.guesses_left} incorrect guesses remaining!"
    else
      puts "\nUnfortunately, you lost! The word was: #{@round.word}"
    end
  end

  private

  def main_loop
    until @round.guesses_left.zero?
      return true if @round.won?

      show_status
      guess = valid_player_letter
      save_round if guess == 'save'
      next if guess.nil?
      next unless included?(guess)

      @round.show_position(guess)
    end
    false
  end

  def included?(guess)
    return true if @round.letter_included?(guess)

    @round.guesses_left -= 1
    @round.incorrect_letters << guess
  end

  def show_status
    incorrect_letters = @round.incorrect_letters.join(' ')
    masked_word = @round.masked_word.join(' ')

    puts "\nIncorrect Guesses Remaining: #{@round.guesses_left}"
    puts "Incorrect Letters: #{incorrect_letters}"
    puts "Known Letters: #{masked_word}\n"
  end
end
