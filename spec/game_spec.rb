require 'spec_helper'
require_relative "../lib/game"

RSpec.describe Game do
  it 'Has a valid factory' do
    path = 'spec/fixtures/test.game.1.txt'
    game = Game.new(path)
    expect(game.class).to be Game
  end

  # it 'generate first frame' do
  #   path = 'spec/fixtures/test.all-0.txt'
  #   path = 'spec/fixtures/test.all-F.txt'
  #   path = 'spec/fixtures/test.all-10.txt'
  #   game = Game.new(path)
  #   player = game.players.first
  #   frame = player.frames.first
  #   expect(frame.score).to be 3
  # end

  xit 'generate all 0 game'
  xit 'generate all F game'
  xit 'generate all 10 game'
end
