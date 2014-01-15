require "minitest/colorize"

module Minitest
  def self.plugin_colorize_init(options)
    io = Colorize.new(options[:io])

    self.reporter.reporters.grep(Minitest::Reporter).each do |rep|
      rep.io = io
    end
  end
end
