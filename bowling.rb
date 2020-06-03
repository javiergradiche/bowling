require 'thor'

class Bowling < Thor
  desc "game FILE.txt", "game bowling game with FILE.txt"
  def game(file)
    puts "Read game from '#{file}'"
  end
end

Bowling.start(ARGV)


