module Bricklayer
  module Util
    extend self

    def unpack(file, dest)
      max = %x(tar -tzvf #{file} | wc -l).chomp
      command_with_bars(max, "mkdir -p #{dest}; tar -xzvf #{file} -C #{dest}")
    end

    def command_with_bars(max, command)
      bar = ProgressBar.new(max.to_i)
      PTY.spawn(command) do |stdin, stdout, pid|
        stdin.each do |current|
          bar.increment!
        end rescue nil
      end
    end
  end
end
