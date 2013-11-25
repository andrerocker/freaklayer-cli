module Bricklayer
  module Download
    extend self

    def build(config)
      Bricklayer::Logger.info "Downloading package"
      url = "#{config.get(:bricklayer)}/download/#{config.get(:project)}"
      explode(config, Bricklayer::Http.download(url))
    end

    private
      def explode(config, tempfile)
        Bricklayer::Logger.line
        Bricklayer::Logger.line
        output_path = config.get(:output_path)
        Bricklayer::Logger.info "Extract package to #{output_path}"
        Bricklayer::Logger.debug "tar -xzvf #{tempfile.path} -C #{output_path}"
        Bricklayer::Util.unpack(tempfile.path, output_path)
      end
  end
end
