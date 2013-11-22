require "trollop"

class Configuration
  def self.build(file)
    @configuration = Hash.new
    instance_eval File.read(file)
    parse_argv
    self
  end

  def self.repository(repo)
    @configuration[:repository] = repo
  end

  def self.repository_branch(branch)
    @configuration[:repository_branch] = branch
  end

  def self.build_image(build_image)
    @configuration[:build_image] = build_image
  end

  def self.project(project)
    @configuration[:project] = project
  end

  def self.bricklayer(bricklayer)
    @configuration[:bricklayer] = bricklayer
  end

  def self.to_hash
    @configuration
  end

  def self.get(key)
    @configuration[key]
  end

  private
  def self.parse_argv
    @configuration.merge!(Trollop::options do
      configuration = Configuration.to_hash
      opt :repository_branch, "Repository Branch", :default => configuration[:repository_branch]
      opt :build_image, "Builder Image Name", :default => configuration[:build_image]
      opt :project, "Project Name", :default => configuration[:project]
      opt :repository, "Git Repository", :default => configuration[:repository]
    end)
  end
end
