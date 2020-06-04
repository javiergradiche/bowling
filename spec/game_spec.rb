require 'spec_helper'
require_relative "../lib/game"

RSpec.describe Game do
  it 'Has a valid factory' do
    path = 'spec/fixtures/test.game.1.txt'
    game = Game.new(path)
    expect(game.class).to be Game
  end

  # it 'generate first frame' do
  #   path = 'spec/fixtures/test.1player-1frame.txt'
  #   game = Game.new(path)
  #   player = game.players.first
  #   frame = player.frames.first
  #   expect(frame.score).to be 3
  # end
end
