class Bricklayer::Commands::Build::Download
  def self.build(config)
    Bricklayer::Logger.info "Downloading package"
    url = "#{config.bricklayer}/download/#{config.project}"
    explode(config, Bricklayer::Commands::Build::Http.download(url))
  end

  private
    def self.explode(config, tempfile)
      Bricklayer::Logger.line
      Bricklayer::Logger.line
      output_path = config.output_path
      Bricklayer::Logger.info "Extract package to #{output_path}"
      Bricklayer::Logger.debug "tar -xzvf #{tempfile.path} -C #{output_path}"
      Bricklayer::Util.unpack(tempfile.path, output_path)
    end
end
