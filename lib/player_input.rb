# frozen_string_literal: true

# Module with methods to get & validate player input
module PlayerInput
  def valid_player_letter
    puts 'Input your guess, a letter from A to Z (Type \'SAVE\' to save the game)'
    g = gets.chomp
    return 'save' if g == 'SAVE'

    g.downcase!
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
