class Bricklayer::Commands::Build::Workspace
  def self.build(config)
    Bricklayer::Logger.info "Creating initial workspace and clone project"
    url = "#{config.bricklayer}/workspace/#{config.project}/branch/#{config.repository_branch}"
    params = { repository: config.repository }
    Bricklayer::Commands::Build::Http.post url, false, params
  end
end
