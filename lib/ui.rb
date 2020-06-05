class UI
  def initialize(game)
    @game = game
  end

  def to_s
    puts draw_scoring
  end
  
  def draw_scoring
    draw_header + draw_players
  end

  def draw_header
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t7\t\t8\t\t9\t\t10\n"
  end

  def draw_players
    output = ''
    @game.players.each do |player_name, player|
      output += "#{player.name}\n"
      output += draw_pinfalls(player.frames.map {|f| format_falls(f)})
      output += draw_score(player.frames.map {|f| format_score(f)})
    end
    output
  end

  def draw_pinfalls(pinfalls)
    o_pinfalls = "Pinfalls\t\t"
    o_pinfalls += pinfalls.join("\t\t")
    o_pinfalls += "\n"
  end
  
  def draw_score(scores)
    o_score = "Score\t\t"
    o_score += scores.join("\t\t")
    o_score += "\n"
  end

  def format_falls(frame)
    first_char = (frame.first_bowl == 10)? "X": frame.first_bowl
    second_char = (frame.second_bowl == 10)? "X": (frame.second_bowl||'\t')
    third_char = (framw.third_bowl == 10)? "X": (frame.third_bowl||'\t')
    # if spare?
    #   first_char = "X"
    # elsif 
    # end
    "\t#{first_char}\t#{second_char}\t#{third_char}"
  end

  def format_scores(frame)
    "\t\t#{@score}"
  end
end