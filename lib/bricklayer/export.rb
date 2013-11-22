module Bricklayer
  module Export
    extend self

    def build(config)
      Bricklayer::Logger.info "Build package to export project"
      url = "#{config.get(:bricklayer)}/export/#{config.get(:project)}"
      Bricklayer::Http.post url
    end
  end
end
