module Bricklayer
  module Download
    extend self

    def build(config)
      Bricklayer::Logger.info "Build package to export project"
      url = "#{config.get(:bricklayer)}/download/#{config.get(:project)}"
      explode(config, Bricklayer::Http.download(url))
    end

    private
      def explode(config, tempfile)
        archive = Archive.new(tempfile.path)
        archive.each{|entry| puts entry.methods}
      end
  end
end
