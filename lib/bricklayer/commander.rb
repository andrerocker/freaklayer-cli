require "bricklayer"
require "bricklayer/config"
require "commander/import"

program :name, "Bricklayer Package Builder"
program :version, "0.0.1"
program :description, "Your Application Build Tool"

command :build do |cmd|
  cmd.syntax = "Use: bl build Or bl build [options] to overwrite Bricklayer properties"
  cmd.description = "Build an application based on Bricklayer file properties"
  cmd.option "--repository REPOSITORY", String, "project git repository"
  cmd.action do |args, options|
    Bricklayer::Commands::BuildCommand.build(Bricklayer::Config.new("Bricklayer", options))
  end
end

command :install do |cmd|
  cmd.description = "Create Bricklayer config file"
  cmd.option "--path PATH", String, "default: CURDIR"
end
