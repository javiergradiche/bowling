class Player
  attr_accessor :name, :pinfalls, :scores, :frames

  def initialize(name)
    @pinfalls = []
    @scores = []
    @frames = []
    @name = name
  end
  
  def add_fall(falls)
    @pinfalls << falls
  end
end
