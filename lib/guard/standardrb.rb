require "guard/plugin"
require "guard/standardrb/version"

module Guard
  class Standardrb < Plugin
    def initialize(opts = {})
      super

      @options = {
        fix: false,
        all_on_start: false,
        progress: false
      }.merge(opts)
    end

    def start
      Guard::UI.info "Inspecting Ruby code style of all files with standardrb"
      Guard::UI.info "Standardrb --fix = #{@options[:fix]}"
      run_all if @options[:all_on_start]
    end

    def run_all
      inspect_with_standardrb
    end

    def run_on_additions(paths)
      Guard::UI.info "StandardRb a file was added"
      inspect_with_standardrb(paths)
    end

    def run_on_modifications(paths)
      Guard::UI.info "StandardRb a file was modified"
      inspect_with_standardrb(paths)

      $stdout.puts paths if paths
    end

    def inspect_with_standardrb(paths = [])
      args = ["bundle", "exec", "standardrb"]
      args << "--fix" if @options[:fix]
      args << ["--format", "progress"] if @options[:progress]

      args.flatten!
      args += paths

      system(*args)
    end
  end
end
