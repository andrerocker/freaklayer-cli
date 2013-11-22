require "colorize"

module Bricklayer
  module Logger
    extend self

    def info(message)
      puts "#{message}".green
    end

    def debug(message)
      puts "  #{message}".yellow
    end

    def output(message)
      puts "  #{message}"
    end
  end
end
