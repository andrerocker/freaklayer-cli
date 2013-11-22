require "excon"

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
  end
end
