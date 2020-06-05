require 'spec_helper'
require_relative "../lib/player"

RSpec.describe Player do
  before(:each) do
    @player = Player.new('Javier')
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
    @player.add_fall(10)
  end

  it 'Has a valid factory' do
    expect(@player.name).to eq 'Javier'
  end
 
  context 'Frames Generation' do
    it 'First frame generation' do
      @player.generate_frames
      frame = @player.frames.first
      expect(frame.class).to be Frame
      expect(frame.first_bowl).to eq 10
      expect(@player.frames.size).to eq 10
    end
  end

end
