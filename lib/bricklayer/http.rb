module Bricklayer
  module Http
    extend self

    def post(url, params = {})
      Bricklayer::Logger.debug "POST #{url} #{params}"
      Excon.post(url, {
        body: URI.encode_www_form(params),
        headers: { "Content-Type" => "application/x-www-form-urlencoded" },
        response_block: chunk_processor
      })
      puts
    end

    def download(url)
      Bricklayer::Logger.debug "GET #{url}"
      temp = Tempfile.new("build-file")

      streamer = lambda do |chunk, remaining_bytes, total_bytes|
        bar = resolve_bar(total_bytes)
        temp.write(chunk)
        bar.increment!(chunk.size)
      end

      Excon.get(url, :response_block => streamer)
      temp
    end

    private
      def chunk_processor
        @chunk ||= streammer = lambda do |chunk,_,_|
          chunk.split("\n").
            collect(&:strip).
            collect(&:chomp).
            delete_if(&:empty?).
            each {|current| Bricklayer::Logger.output(current)}
        end
      end

      def resolve_bar(size)
        @bar ||= begin
          ProgressBar.new(size)
        end
      end
  end
end
