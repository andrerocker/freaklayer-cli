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
        Bricklayer::Logger.info "Extract package to bacon"
        archive = Archive.new(tempfile.path)
        archive.each do |entry|
          puts entry.methods
        end
      end
  end
end
