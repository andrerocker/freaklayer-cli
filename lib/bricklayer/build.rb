module Bricklayer
  module Builder
    extend self

    def build(config)
      Bricklayer::Logger.info "Building project"
      url = "#{config.get(:bricklayer)}/build/#{config.get(:project)}/image/#{config.get(:build_image)}"
      Bricklayer::Http.post url, false
    end
  end
end
