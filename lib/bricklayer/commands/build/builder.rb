class Bricklayer::Commands::Build::Builder
  def self.build(config)
    Bricklayer::Logger.info "Building project"
    url = "#{config.bricklayer}/build/#{config.project}/image/#{config.build_image}"
    Bricklayer::Http.post url, false
  end
end
