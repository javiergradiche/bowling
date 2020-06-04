class FrameException < Exception; end;

class Frame
  attr_accessor :first_bowl, :second_bowl, :third_bowl, :position, :score

  def initialize(options = {})
    @position = options[:position]
    @first_bowl = options[:first_bowl]
    @second_bowl = options[:second_bowl]
    @third_bowl = options[:third_bowl]
    @score = 0
  end

  def calculate_score(acum_score, first_next_frame = nil, second_next_frame = nil)
    @score = acum_score + bowls_score
    unless last?
      @score += calculate_score_first_next(first_next_frame)
      @score += calculate_score_second_next(first_next_frame, second_next_frame) 
    end
    @score
  end

  def calculate_score_first_next(first_next_frame)
    first_next_frame.first_bowl
  end

  def calculate_score_second_next(first_next_frame, second_next_frame)
    second_next_score = 0
    if self.strike? && first_next_frame.strike?
      second_next_score = (first_next_frame.last?)? first_next_frame.second_bowl : second_next_frame.first_bowl
    elsif self.strike? && !first_next_frame.strike?
      second_next_score = first_next_frame.second_bowl
    end
    second_next_score
  end

  def bowls_score
    (@first_bowl||0) + (@second_bowl||0) + (@third_bowl||0)
  end

  def add_fall(falls)
    return false if finished?

    if @first_bowl.nil?
      @first_bowl = falls
    elsif @second_bowl.nil?
      @second_bowl = falls
    else
      @third_bowl = falls
    end
  end

  def curated_falls(falls)
    (falls == 'F')? 0 : falls.to_i
  end

  def add_score(score)
    @score = score
  end

  def next_fall
    @first_bowl || @second_bowl || @third_bowl
  end

  def strike?
    @first_bowl == 10
  end

  def spare?
    ((@first_bowl||0) + (@second_bowl||0)) == 10
  end

  def open?
    ((@first_bowl||0) + (@second_bowl||0)) < 10
  end

  def finished?
    return (strike?||spare?||(@second_bowl.is_a?(Integer))) if @position < 10
    return ((strike?&&@third_bowl.is_a?(Integer))||(!strike?&&@second_bowl.is_a?(Integer))) if @position == 10
    return false
  end

  def valid?
    !@position.nil? && @position > 0 && position < 11
  end

  def last?
    (@position == 10)
  end

end
