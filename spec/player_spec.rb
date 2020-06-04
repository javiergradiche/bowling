require 'spec_helper'
require_relative "../lib/player"
require_relative "../lib/score"

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
      expect(frame.third_bowl).to eq nil
    end
  end

  context 'Score Generation' do
    it 'First frame open score' do 
      frames = @player.generate_frames
      position = 1
      frame_score = Score.calculate(position, frames)
      expect(frame_score).to eq 3
    end
  end
end
