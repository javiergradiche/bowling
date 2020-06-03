require 'spec_helper'
require_relative "../lib/game"

RSpec.describe Game do
  it 'Has a valid factory' do
    path = 'fixtures/test.game.1.txt'
    game = Game.new(path)
    expect(game.class).to be Game
  end
end
