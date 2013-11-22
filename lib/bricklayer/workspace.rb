module Bricklayer
  module Workspace
    extend self

    def build(config)
      Bricklayer::Logger.info "Creating initial workspace and clone project"
      url = "#{config.get(:bricklayer)}/workspace/#{config.get(:project)}/branch/#{config.get(:repository_branch)}"
      params = { repository: config.get(:repository) }
      Bricklayer::Http.post url, params
    end
  end
end
