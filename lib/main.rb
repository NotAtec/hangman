# frozen_string_literal: true

require_relative 'round_management'
require_relative 'player_input'
require_relative 'round'
require_relative 'game'

def load?
  puts 'Do you want to load a previously saved round? (y/n)'
  gets.downcase.chomp == 'y'
end

game = Game.new(load?)
game.play
