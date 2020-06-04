require 'spec_helper'
require_relative "../lib/frame"

RSpec.describe Frame do
  context 'Validation' do
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
  end

  context 'States' do
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

    it 'Finished for frame < 10' do
      frame = Frame.new({
        position: 1,
        first_bowl: 2,
        second_bowl: 3
      })
      expect(frame.finished?).to be true
    end

    it 'Finished for frame == 10 with strike' do
      frame = Frame.new({
        position: 10,
        first_bowl: 10,
        second_bowl: 3
      })
      expect(frame.strike?).to be true
      expect(frame.finished?).to be false

      frame = Frame.new({
        position: 10,
        first_bowl: 10,
        second_bowl: 3,
        third_bowl: 5,
      })
      expect(frame.strike?).to be true
      expect(frame.finished?).to be true
    end

    it 'Finished for frame == 10 with spare' do
      frame = Frame.new({
        position: 10,
        first_bowl: 2,
        second_bowl: 8
      })
      expect(frame.spare?).to be true
      expect(frame.finished?).to be true
    end

    it 'Finished for frame == 10 with open' do
      frame = Frame.new({
        position: 10,
        first_bowl: 2,
        second_bowl: 3
      })
      expect(frame.open?).to be true
      expect(frame.finished?).to be true
    end
  end

  context 'Popuplate frames 1..9' do
    before(:each) do
      @frame = Frame.new({position: 1})
    end

    it 'Add falls' do
      @frame.add_fall(1)
      expect(@frame.finished?).to be false
      @frame.add_fall(1)
      expect(@frame.finished?).to be true
    end

    it 'Return false if you want to add more than 2 falls' do
      @frame.add_fall(1)
      @frame.add_fall(2)
      expect(@frame.valid?).to be true
      expect(@frame.add_fall(3)).to be false
      expect(@frame.third_bowl).to be nil
    end

    it 'Strike is working' do
      @frame.add_fall(10)
      expect(@frame.strike?).to be true
      expect(@frame.finished?).to be true
    end

    it 'Spare is working' do
      @frame.add_fall(2)
      @frame.add_fall(8)
      expect(@frame.spare?).to be true
      expect(@frame.finished?).to be true
    end
  end

  context 'Popuplate frame 10' do
    before(:each) do
      @frame = Frame.new({position: 10})
    end

    it 'Add 3 falls if strike at first' do
      @frame.add_fall(10)
      @frame.add_fall(1)
      expect(@frame.finished?).to be false
      @frame.add_fall(1)
      expect(@frame.finished?).to be true
    end

    it 'Only 2 falls if not strike at first' do
      @frame = Frame.new({position: 10})
      @frame.add_fall(9)
      @frame.add_fall(1)
      expect(@frame.finished?).to be true
      expect(@frame.add_fall(3)).to be false
      expect(@frame.third_bowl).to be nil
    end
  end

  context 'Calculate score frames 1..9' do
    before(:each) do
      @frame1 = Frame.new({position: 1})
      @frame2 = Frame.new({position: 2})
      @frame3 = Frame.new({position: 3})
    end

    it "Strike first frame, spare second" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 8
      @frame2.second_bowl = 2
      @frame1.calculate_score(@frame2, @frame3)
      expect(@frame1.score).to be 20
    end

    it "Strike first frame, open second" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 8
      @frame2.second_bowl = 1
      @frame1.calculate_score(@frame2, @frame3)
      expect(@frame1.score).to be 19
    end

    it "Strike first & second frame, spare third"
    it "Strike first & second frame, open third"
    it "Strike first, second & third frame"
    it "Spare first frame, strike second"
    it "Spare first frame, spare second"
    it "Spare first frame, open second"
  end

  context 'Calculate score frame 10' do
    before(:each) do
      @frame = Frame.new({position: 10})
    end

    it 'Add 3 falls if strike at first' do
      @frame.add_fall(10)
      @frame.add_fall(1)
      expect(@frame.finished?).to be false
      @frame.add_fall(1)
      expect(@frame.finished?).to be true
    end

    it 'Only 2 falls if not strike at first' do
      @frame = Frame.new({position: 10})
      @frame.add_fall(9)
      @frame.add_fall(1)
      expect(@frame.finished?).to be true
      expect(@frame.add_fall(3)).to be false
      expect(@frame.third_bowl).to be nil
    end
  end


end
