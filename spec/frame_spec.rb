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

    it 'Not finished for frame == 10 with spare' do
      frame = Frame.new({
        position: 10,
        first_bowl: 2,
        second_bowl: 8
      })
      expect(frame.spare?).to be true
      expect(frame.finished?).to be false
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

    it 'Not finished for frame == 10 with strike, but not third' do
      frame = Frame.new({
        position: 10,
        first_bowl: 10,
        second_bowl: 3
      })
      expect(frame.finished?).to be false
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

    it 'Add 3 falls if not strike at first' do
      @frame = Frame.new({position: 10})
      @frame.add_fall(9)
      @frame.add_fall(1)
      expect(@frame.finished?).to be false
      @frame.add_fall(3)
      expect(@frame.finished?).to be true
    end
  end

  context 'Calculate score frames 1..8' do
    before(:each) do
      @frame1 = Frame.new({position: 1})
      @frame2 = Frame.new({position: 2})
      @frame3 = Frame.new({position: 3})
    end

    it "Strike first frame, spare second" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 8
      @frame2.second_bowl = 2
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 20
    end

    it "Strike first frame, open second" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 8
      @frame2.second_bowl = 1
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 19
    end

    it "Strike first & second frame, spare third" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 10
      @frame3.first_bowl = 5
      @frame3.second_bowl = 5
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 25
    end

    it "Strike first & second frame, open third" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 10
      @frame3.first_bowl = 5
      @frame3.second_bowl = 0
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 25
    end

    it "Strike first, second & third frame" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 10
      @frame3.first_bowl = 10
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 30
    end

    it "Strike first, second, third and fourth frame" do
      @frame1.first_bowl = 10
      @frame2.first_bowl = 10
      @frame3.first_bowl = 10
      @frame4 = Frame.new({position: 4})
      @frame5 = Frame.new({position: 5})
      @frame6 = Frame.new({position: 6})
      @frame4.first_bowl = 10
      @frame5.first_bowl = 10
      @frame6.first_bowl = 10
      @frame1.calculate_score(0, @frame2, @frame3)
      @frame2.calculate_score(30, @frame3, @frame4)
      @frame3.calculate_score(60, @frame4, @frame5)
      @frame4.calculate_score(90, @frame5, @frame6)
      expect(@frame1.score).to be 30
      expect(@frame2.score).to be 60
      expect(@frame3.score).to be 90
      expect(@frame4.score).to be 120
    end

    it "Spare first frame, strike second" do
      @frame1.first_bowl = 5
      @frame1.second_bowl = 5
      @frame2.first_bowl = 10
      @frame3.first_bowl = 5
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 20
    end

    it "Spare first frame, spare second" do
      @frame1.first_bowl = 5
      @frame1.second_bowl = 5
      @frame2.first_bowl = 5
      @frame2.second_bowl = 5
      @frame3.first_bowl = 10
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 15
    end

    it "Spare first frame, open second" do
      @frame1.first_bowl = 5
      @frame1.second_bowl = 5
      @frame2.first_bowl = 5
      @frame2.second_bowl = 2
      @frame3.first_bowl = 5
      @frame1.calculate_score(0, @frame2, @frame3)
      expect(@frame1.score).to be 15
    end
  end

  context 'Calculate score frames 9..10' do
    before(:each) do
      @frame9 = Frame.new({position: 9})
      @frame10 = Frame.new({position: 10})
    end

    it "Strike frame 9, Strike,Strike,Stike frame 10 " do
      @frame9.first_bowl = 10
      @frame10.first_bowl = 10
      @frame10.second_bowl = 10
      @frame10.third_bowl = 10
      @frame9.calculate_score(0, @frame10, nil)
      expect(@frame9.score).to be 30
      @frame10.calculate_score(30, nil, nil)
      expect(@frame10.score).to be 60
    end

    it "Strike frame 9, Strike,5,Spare frame 10 " do
      @frame9.first_bowl = 10
      @frame10.first_bowl = 10
      @frame10.second_bowl = 5
      @frame10.third_bowl = 5
      @frame9.calculate_score(0, @frame10, nil)
      expect(@frame9.score).to be 25
      @frame10.calculate_score(25, nil, nil)
      expect(@frame10.score).to be 45
    end

    it "Strike frame 9, Strike,5,3 frame 10 " do
      @frame9.first_bowl = 10
      @frame10.first_bowl = 10
      @frame10.second_bowl = 5
      @frame10.third_bowl = 3
      @frame9.calculate_score(0, @frame10, nil)
      expect(@frame9.score).to be 25
      @frame10.calculate_score(25, nil, nil)
      expect(@frame10.score).to be 43
    end
  end
end
