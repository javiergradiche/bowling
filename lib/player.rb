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
    @frames << Frame.new({position: frame_index})
    @pinfalls.each do |pinfall|
      current_frame = frames[frame_index-1]
      if current_frame.finished?
        frame_index += 1
        @frames << Frame.new({position: frame_index})
        current_frame = frames[frame_index-1]
      end
      result = current_frame.add_fall(pinfall)
      return false unless result # check invalid input
    end
    return false if frame_index != 10 # check invalid input
  end

  def generate_scores
    acum_score = 0
    @frames.each_with_index do |frame, index|
      if frame.last?
        frame.calculate_score(acum_score, nil, nil)
      elsif frame.position == 9
        frame.calculate_score(acum_score, @frames[index+1], nil)
      else
        frame.calculate_score(acum_score, @frames[index+1], @frames[index+2])
      end
      acum_score = frame.score
    end
  end
end
