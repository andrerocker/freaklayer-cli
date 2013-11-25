
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

    def line
      puts
    end
  end
end
