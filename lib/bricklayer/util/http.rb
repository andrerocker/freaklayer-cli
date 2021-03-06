require "excon"
require "tempfile"

module Bricklayer::Http
  extend self

  def post(url, bar, params = {})
    Bricklayer::Logger.debug "POST #{url} #{params}"
    Excon.post(url, {
      body: URI.encode_www_form(params),
      headers: { "Content-Type" => "application/x-www-form-urlencoded" },
      response_block: chunk_processor(bar)
    })
    Bricklayer::Logger.line
  end

  def get(url)
    Bricklayer::Logger.debug "GET #{url}"
    Excon.get(url)
  end

  def download(url)
    Bricklayer::Logger.debug "GET #{url}"
    temp = Tempfile.new("build-file")
    key  = Time.now

    streamer = lambda do |chunk, remaining_bytes, total_bytes|
      bar = Bricklayer::Util.resolve_bar(total_bytes, key)
      temp.write(chunk)
      bar.increment!(chunk.size)
    end

    Excon.get(url, :response_block => streamer)
    temp
  end

  private
    def chunk_processor(bar = false)
      streammer = lambda do |chunk,_,_|
        chunk.split("\n").
          collect(&:strip).
          collect(&:chomp).
          delete_if(&:empty?).each do |current|
            if bar
              bar.increment!
            else
              Bricklayer::Logger.output(current)
            end
          end
      end
    end
end
