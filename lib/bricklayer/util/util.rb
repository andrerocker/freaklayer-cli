require "pty"

module Bricklayer::Util
  extend self
  BARS = {}

  def unpack(file, dest)
    max = %x(tar -tzvf #{file} | wc -l).chomp
    command_with_bars(max, "mkdir -p #{dest}; tar -xzvf #{file} -C #{dest}")
  end

  def command_with_bars(max, command)
    bar = resolve_bar(max.to_i)
    PTY.spawn(command) do |stdin, stdout, pid|
      stdin.each do |current|
        bar.increment!
      end rescue nil
    end
  end

  def resolve_bar(size, key = Time.now)
    BARS[key] ||= ProgressBar.new(size)
  end
end
