require_relative 'frame'

class Player
  attr_accessor :name, :pinfalls, :frames

  def initialize(name)
    @pinfalls = []
    @frames = []
    @name = name
  end
  
  def add_fall(falls)
    @pinfalls << falls
  end

  def generate_frames
    frame_index = 1
    frames << Frame.new({position: frame_index})
    @pinfalls.each do |pinfall|
      current_frame = frames[frame_index]
      if current_frame.finished?
        frame_index += 1
        frames << Frame.new({position: frame_index})
      end
      current_frame.add_bowl(pinfall)
    end
    return false if frame_index != 10
  end

  def generate_frame

  end
end
