# frozen_string_literal: true

# Module with methods to manage loading & creating rounds
module RoundManagement
  def load_round; end

  def new_round
    @round_instance = Round.new
  end

  def save_round; end
end
