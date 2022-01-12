# frozen_string_literal: true

# Module with methods to manage loading & creating rounds
module RoundManagement
  def load_round
    puts 'Choose the number matching your save-file'
    Dir.glob('saves/*.{yml}').each_with_index { |f, i| puts "#{i} => #{f}" }
    idx = gets.chomp

    unless idx.to_i.to_s == idx
      puts 'That\'s not a number, try again!'
      return load_round
    end

    save = Dir.glob('saves/*.{yml}')[idx.to_i]
    @round = YAML.safe_load(File.read(save))
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
