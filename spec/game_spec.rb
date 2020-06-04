require 'spec_helper'
require_relative "../lib/game"

RSpec.describe Game do
  it 'Has a valid factory' do
    path = 'spec/fixtures/test.game-example.txt'
    game = Game.new(path)
    expect(game.class).to be Game
  end

  it 'generate all sum 9 game' do
    path = 'spec/fixtures/test.1player-all-open.txt'
    game = Game.new(path)
    player = game.players['Javi']
    player.generate_frames
    player.generate_scores
    frames = player.frames
    expect(player.frames.size).to be 10
    expect(frames[0].score).to be 9
    expect(frames[5].score).to be 45
    expect(frames[9].score).to be 90
  end

  it 'generate all 0 game' do
    path = 'spec/fixtures/test.1player-all-0.txt'
    game = Game.new(path)
    player = game.players['Javi']
    player.generate_frames
    player.generate_scores
    frames = player.frames
    expect(player.frames.size).to be 10
    expect(frames[0].score).to be 0
    expect(frames[5].score).to be 0
    expect(frames[9].score).to be 0
  end

  xit 'generate all F game'
  xit 'generate all 10 game'
end
