require "excon"

require "bricklayer/http"
require "bricklayer/logger"

module Bricklayer
  module CLI
    extend self

    def build_workspace(config)
      Bricklayer::Logger.info "Creating initial workspace and clone project"
      url = "#{config.get(:bricklayer)}/workspace/#{config.get(:project)}/branch/#{config.get(:repository_branch)}"
      params = { repository: config.get(:repository) }
      Bricklayer::Http.post url, params
    end

    def build_project(config)
      Bricklayer::Logger.info "Building project"
      url = "#{config.get(:bricklayer)}/build/#{config.get(:project)}/image/#{config.get(:build_image)}"
      Bricklayer::Http.post url
    end
  end
end
