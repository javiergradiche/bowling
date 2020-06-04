class FrameException < Exception; end;

class Frame
  attr_accessor :first_bowl, :second_bowl, :third_bowl, :position, :score

  def initialize(options = {})
    @position = options[:position] || nil
    @first_bowl = options[:first_bowl] || 0
    @second_bowl = options[:second_bowl] || 0
    @third_bowl = options[:third_bowl] || 0
  end

  def strike?
    @first_bowl == 10
  end

  def spare?
    (@first_bowl + @second_bowl) == 10
  end

  def open?
    (@first_bowl + @second_bowl) < 10
  end

  def valid?
    !@position.nil? && @position > 0 && position < 11
  end
end
