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

end
