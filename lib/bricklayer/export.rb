module Bricklayer
  module Export
    extend self

    def build(config)
      Bricklayer::Logger.info "Build package to export project"
      url = "#{config.get(:bricklayer)}/export/#{config.get(:project)}"
      bar = ProgressBar.new(total_files(config))
      Bricklayer::Http.post url, bar
      Bricklayer::Logger.line
    end

    private
      def total_files(config)
        url = "#{config.get(:bricklayer)}/export/#{config.get(:project)}"
        Bricklayer::Http.get(url).body.to_i
      end
  end
end
