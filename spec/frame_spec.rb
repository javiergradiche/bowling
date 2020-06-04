require 'spec_helper'
require_relative "../lib/frame"

RSpec.describe Frame do
  it 'Mandatory position option' do
    frame = Frame.new
    expect(frame.valid?).to be false
  end

  it 'Position option between 1..10' do
    frame = Frame.new({position: 0})
    expect(frame.valid?).to be false
    frame2 = Frame.new({position: 1})
    expect(frame2.valid?).to be true
    frame3 = Frame.new({position: 10})
    expect(frame3.valid?).to be true
    frame4 = Frame.new({position: 11})
    expect(frame4.valid?).to be false
  end

  it 'Strike if first bowl fall 10' do
    frame = Frame.new({
      position: 1,
      first_bowl: 10
    })
    expect(frame.strike?).to be true
  end

  it 'Spare if first 1 + second 9 = total fall 10' do
    frame = Frame.new({
      position: 1,
      first_bowl: 1,
      second_bowl: 9
    })
    expect(frame.spare?).to be true
  end

  it 'Spare if first 9 + second 1 = total fall 10' do
    frame = Frame.new({
      position: 1,
      first_bowl: 1,
      second_bowl: 9
    })
    expect(frame.spare?).to be true
  end

  it 'Spare if first 0 + second 10 = total fall 10' do
    frame = Frame.new({
      position: 1,
      first_bowl: 0,
      second_bowl: 10
    })
    expect(frame.spare?).to be true
  end

  it 'Open when first + seconds < 10' do
    frame = Frame.new({
      position: 1,
      first_bowl: 2,
      second_bowl: 3
    })
    expect(frame.spare?).to be false
    expect(frame.open?).to be true
  end


end
