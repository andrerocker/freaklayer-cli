class Bricklayer::Commands::Build::Export
  def self.build(config)
    Bricklayer::Logger.info "Build package to export project"
    url = "#{config.bricklayer}/export/#{config.project}"
    bar = ProgressBar.new(total_files(config))
    Bricklayer::Http.post(url, bar)
    Bricklayer::Logger.line
  end

  private
    def self.total_files(config)
      url = "#{config.bricklayer}/export/#{config.project}"
      Bricklayer::Http.get(url).body.to_i
    end
end
