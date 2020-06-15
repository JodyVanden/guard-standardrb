require "guard"
require "guard/plugin"
require "guard/standardrb/version"

module Guard
  class Standardrb < Plugin
    attr_reader :fix

    def initialize(opts = {})
      super
      @fix = opts[:fix]
    end

    def start
      UI.info "Standardrb --fix = #{fix}"
      UI.info "Inspecting Ruby code style of all files with standardrb"
    end

    def start
      Guard::Compat::UI.info "Inspecting Ruby code style of all files with standardrb"
    end

    def run_on_modifications(res)
      Guard::Compat::UI.info "StandardRb a file was modified"
      inspect_with_standardrb(res)

      $stdout.puts res if res
    end

    def inspect_with_standardrb(paths = [])
      args = ["bundle", "exec", "standardrb"]

      if fix
        args << "--fix"
      end

      args += paths

      system(*args)
    end
  end
end
