# frozen_string_literal: true

require_relative 'round_management'
require_relative 'player_input'
require_relative 'round'
require_relative 'game'
require 'pry-byebug'

def load?
  puts 'Do you want to load a previously saved round? (y/n)'
  gets.downcase.chomp == 'y'
end

binding.pry
# game = Game.new(load?)
# game.play
p test