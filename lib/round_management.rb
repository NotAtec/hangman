# frozen_string_literal: true

require 'date'
# Module with methods to manage loading & creating rounds
module RoundManagement
  def load_round; end

  def new_round
    @round_instance = Round.new
  end

  def save_round
    File.open("saves/#{random_string}.yml", 'w') { |f| f.puts YAML.dump(@round_instance) }
  end

  def random_string
    random = []
    3.times { random << grab_word }
    random.join('')
  end

  def grab_word
    loop do
      sample = File.readlines('5desk.txt').sample.chomp
      next if sample.length < 5 || sample.length > 12

      return sample
    end
  end
end
