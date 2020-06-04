class Frame
  attr_accessor :first_bowl, :second_bowl, :third_bowl

  def initialize(bowls = {})
    @first_bowl = bowls[:first_bowl] || 0
    @second_bowl = bowls[:second_bowl] || nil
    @third_bowl = bowls[:third_bowl] || nil
  end

  def strike?
    @first_bowl == 10
  end

  def spare?
    (@first_bowl + @second_bowl) == 10
  end
end
