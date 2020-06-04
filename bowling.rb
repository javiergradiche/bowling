require 'thor'
require_relative './lib/game'
require_relative './lib/ui'

class Bowling < Thor
  def self.exit_on_failure?
    true
  end

  desc "game GAME.txt", "game bowling game with GAME.txt"
  def game(file_name)
    game = Game.new(file_name)
    ui = UI.new(game)
    puts ui.to_s
  end
end

Bowling.start(ARGV)


