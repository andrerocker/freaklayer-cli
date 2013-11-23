module Bricklayer
  class Configuration
    class << self
      def build(file)
        @configuration = Hash.new
        instance_eval File.read(file)
        parse_argv
        self
      end

      def repository(repo)
        @configuration[:repository] = repo
      end

      def repository_branch(branch)
        @configuration[:repository_branch] = branch
      end

      def build_image(build_image)
        @configuration[:build_image] = build_image
      end

      def project(project)
        @configuration[:project] = project
      end

      def bricklayer(bricklayer)
        @configuration[:bricklayer] = bricklayer
      end

      def output_format(output_format)
        @configuration[:output_format] = output_format
      end

      def output_path(output_path)
        @configuration[:output_path] = output_path
      end

      def to_hash
        @configuration
      end

      def get(key)
        @configuration[key]
      end

      private
        def parse_argv
          @configuration.merge!(Trollop::options do
            configuration = Configuration.to_hash
            opt :bricklayer, "Bricklayer Server URL", :default => configuration[:bricklayer]
            opt :build_image, "Builder Image Name", :default => configuration[:build_image]
            opt :repository_branch, "Repository Branch", :default => configuration[:repository_branch]
            opt :project, "Project Name", :default => configuration[:project]
            opt :repository, "Git Repository", :default => configuration[:repository]
          end)
        end
    end
  end
end
