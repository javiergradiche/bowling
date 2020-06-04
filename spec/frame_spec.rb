require 'spec_helper'
require_relative "../lib/frame"

RSpec.describe Frame do
  it 'Has a valid factory' do
    frame = Frame.new
    expect(frame.class).to be Frame
  end

  it 'Strike if first bowl fall 10' do
    frame = Frame.new({
      first_bowl: 10
    })
    expect(frame.strike?).to be true
  end

  it 'Spare if first 1 + second 9 = total fall 10' do
    frame = Frame.new({
      first_bowl: 1,
      second_bowl: 9
    })
    expect(frame.spare?).to be true
  end

  it 'Spare if first 9 + second 1 = total fall 10' do
    frame = Frame.new({
      first_bowl: 1,
      second_bowl: 9
    })
    expect(frame.spare?).to be true
  end

  it 'Spare if first 0 + second 10 = total fall 10' do
    frame = Frame.new({
      first_bowl: 0,
      second_bowl: 10
    })
    expect(frame.spare?).to be true
  end
end
