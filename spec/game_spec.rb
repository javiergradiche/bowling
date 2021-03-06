require 'spec_helper'
require_relative "../lib/game"

RSpec.describe Game do
  before(:all) do
    game = nil
  end

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
    expect(frames[5].score).to be 54
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

  it 'generate Steve video game' do
    path = 'spec/fixtures/test.1player-video.txt'
    game = Game.new(path)
    player = game.players['Steve']
    player.generate_frames
    player.generate_scores
    frames = player.frames
    expect(player.frames.size).to be 10
    expect(frames[0].score).to be 17
    expect(frames[1].score).to be 30
    expect(frames[2].score).to be 37
    expect(frames[3].score).to be 57
    expect(frames[4].score).to be 77
    expect(frames[5].score).to be 105
    expect(frames[6].score).to be 123
    expect(frames[7].score).to be 131
    expect(frames[8].score).to be 151
    expect(frames[9].score).to be 170
  end

  it 'generate all F game' do
    path = 'spec/fixtures/test.1player-all-F.txt'
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

  it 'generate all 10 game' do
    path = 'spec/fixtures/test.1player-all-10.txt'
    game = Game.new(path)
    player = game.players['Javi']
    player.generate_frames
    player.generate_scores
    frames = player.frames
    expect(player.frames.size).to be 10
    expect(frames[0].score).to be 30
    expect(frames[5].score).to be 180
    expect(frames[9].score).to be 300
  end

  it 'fail generate bad input' do
    path = 'spec/fixtures/test.fail-bad-input.txt'
    expect{ 
      game = Game.new(path)
      player = game.players['Javi']
      player.generate_frames
    }.to raise_exception Exception
  end

  it 'fail generate incomplete game' do
    path = 'spec/fixtures/test.fail-game-incomplete.txt'
    expect{ 
      game = Game.new(path)
      player = game.players['Javi']
      player.generate_frames
    }.to raise_exception Exception
  end

  it 'fail generate bad input' do
    path = 'spec/fixtures/test.fail-game-exceed.txt'
    expect{ 
      game = Game.new(path)
      player = game.players['Javi']
      player.generate_frames
    }.to raise_exception Exception
  end
end
