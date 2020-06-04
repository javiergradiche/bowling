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
      output += draw_pinfalls(player.pinfalls)
      output += draw_score(player.scores)
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
end