# coding: utf-8

require 'guard'
require 'guard/plugin'
require 'guard/standardrb/version'

module Guard
  class Standardrb < Plugin

    def start
      UI.info 'Inspecting Ruby code style of all files with standardrb'
    end

    def run_on_modifications(res)
      UI.info 'StandardRb a file was modified'
      inspect_with_standardrb(res)

      $stdout.puts res if res
    end

    def inspect_with_standardrb(paths = [])
      paths.each do |path|
        system("bundle exec standardrb #{path}")
      end
    end
  end
end
