require 'spec_helper'
require_relative "../lib/ui"

RSpec.describe UI do
  it 'Has a valid factory' do
    game = Game.new('spec/fixtures/test.game.1.txt')
    ui = UI.new(game)
    expect(ui.class).to be UI
  end

  it 'Has a valid header' do
    game = Game.new('spec/fixtures/test.game.1.txt')
    ui = UI.new(game)
    expect(ui.draw_header).to include "Frame"
    expect(ui.draw_players).not_to include "Frame"
  end  
end
