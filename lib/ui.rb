require 'byebug'
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
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\n"
  end

  def draw_players
    output = ''
    @game.players.each do |player_name, player|
      output += "#{player.name}\n"
      output += draw_pinfalls(player.frames.map {|f| format_falls(f)})
      output += draw_score(player.frames.map {|f| format_scores(f.score)})
    end
    output
  end

  def draw_pinfalls(pinfalls)
    o_pinfalls = "Pinfalls\t"
    o_pinfalls += pinfalls.join("\t")
    o_pinfalls += "\n"
  end
  
  def draw_score(scores)
    o_score = "Score\t\t"
    o_score += scores.join("\t\t")
    o_score += "\n"
  end

  def format_falls(frame)
    out = "#{format_first(frame)}#{format_second(frame)}"
    out += "#{format_third(frame)}" if frame.last?
    out
  end

  def format_first(frame)
    if frame.strike?
      if frame.last?
        "X\t"
      else
        "\t"
      end
    else
      "#{frame.first_bowl.to_s}\t"
    end
  end

  def format_second(frame)
    if frame.strike?
      if frame.last?
        (frame.second_bowl == 10)? "X" : "#{frame.second_bowl.to_s}\t"
      else
        "X"
      end
    elsif frame.spare?
      '/'
    else
      "#{frame.second_bowl.to_s}"
    end
  end

  def format_third(frame)
    if frame.last?
      (frame.third_bowl == 10)? "X" : "#{frame.third_bowl.to_s}\t"
    else
      "#{frame.third_bowl.to_s}"
    end
  end

  def format_scores(score)
    "#{score}"
  end
end