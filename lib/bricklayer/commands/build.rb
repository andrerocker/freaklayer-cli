module Bricklayer::Commands::Build; end

require "pty"
require "zlib"
require "excon"
require "tempfile"
require "colorize"
require "progress_bar"
require "archive/tar/minitar"

require "bricklayer/commands/build/http"
require "bricklayer/commands/build/util"
require "bricklayer/commands/build/logger"
require "bricklayer/commands/build/builder"
require "bricklayer/commands/build/export"
require "bricklayer/commands/build/download"
require "bricklayer/commands/build/workspace"

class Bricklayer::Commands::BuildCommand
  def self.build(config)
    Bricklayer::Commands::Build::Workspace.build(config)
    # Bricklayer::Commands::Build::Builder.build(config)
    Bricklayer::Commands::Build::Export.build(config)
    Bricklayer::Commands::Build::Download.build(config)
  end
end
