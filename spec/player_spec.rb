require 'spec_helper'
require_relative "../lib/player"

RSpec.describe Player do
  before(:each) do
    @player = Player.new('Javier')
    @player.add_fall(1)
    @player.add_fall(2)
  end

  it 'Has a valid factory' do
    expect(@player.name).to eq 'Javier'
  end
 
  context 'Frames Generation' do
    it 'First frame generation' do
      @player.generate_frames
      frame = @player.frames.first
      expect(frame.class).to be Frame
      expect(frame.first_bowl).to eq 1
      expect(frame.second_bowl).to eq 2
      expect(frame.score).to be 3
    end
  end

  context 'Score Generation' do
  end
end
