# frozen_string_literal: true

require 'date'
# Module with methods to manage loading & creating rounds
module RoundManagement
  def load_round
    @round = YAML.load(File.read("saves/#{save}.yml"))
    @round
  end

  def new_round
    @round = Round.new
  end

  def save_round
    string = random_string
    File.open("saves/#{string}.yml", 'w') { |f| f.puts YAML.dump(@round) }
    abort("Your round was saved as #{string}.yml in the /saves/ folder")
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
