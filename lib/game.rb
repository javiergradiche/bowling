require_relative 'player'

class Game
  attr_accessor :players
  def initialize(file_path)
    @file_path = file_path
    @players = {}
    parse_input
  end

  def parse_input
    File.open(@file_path).each do |line|
      player_name, falls = line.strip.split(' ')
      @players[player_name] = @players[player_name] || Player.new(player_name) 
      @players[player_name].add_fall(falls)
    end
    generate_frames
    generate_scores
  end

  def generate_frames
    @players.each do |_name, player|
      player.generate_frames
    end
  end
  
  def generate_scores
    @players.each do |_name, player|
      player.generate_scores
    end
  end
end