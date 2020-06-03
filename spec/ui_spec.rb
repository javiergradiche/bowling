require 'spec_helper'
require_relative "../lib/ui"

RSpec.describe UI do
  it 'Has a valid factory' do
    game = Game.new('fixtures/test.game.1.txt')
    ui = UI.new(game.result)
    expect(ui.class).to be UI
  end
end
