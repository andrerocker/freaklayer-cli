require "pty"
require "zlib"
require "excon"
require "trollop"
require "tempfile"
require "colorize"
require "progress_bar"
require "archive/tar/minitar"

require "bricklayer/http"
require "bricklayer/util"
require "bricklayer/build"
require "bricklayer/config"
require "bricklayer/logger"
require "bricklayer/export"
require "bricklayer/download"
require "bricklayer/workspace"

module Bricklayer
  module CLI
    extend self

    def run
      config = Bricklayer::Configuration.build("Bricklayer")
      Bricklayer::Workspace.build(config)
      Bricklayer::Builder.build(config)
      Bricklayer::Export.build(config)
      Bricklayer::Download.build(config)
    end
  end
end
