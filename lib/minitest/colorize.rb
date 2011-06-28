require "minitest/colorize/version"
require "minitest/unit"

module MiniTest
  class Colorize
    attr_accessor :stream

    def initialize(stream = $stdout)
      self.stream = stream.tap do |stream|
        stream.sync = true if stream.respond_to?(:sync=)
      end
    end

    def print(string = nil)
      return stream.print if string.nil?

      if color = colors[string]
        stream.print tint(color, string)
      else
        stream.print string
      end

      unless report.empty?
        stream.puts
        stream.puts
        stream.puts report.shift
        stream.puts
      end
    end

    def puts(string = nil)
      return stream.puts if string.nil?

      if string =~ /(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors, (\d+) skips/
        color = if $3 != '0'
                  colors['F']
                elsif $4 != '0'
                  colors['E']
                elsif $5 != '0'
                  colors['S']
                else
                  colors['.']
                end

        stream.puts tint(color, string)
      else
        stream.puts string
      end
    end

    def method_missing(method, *args, &block)
      stream.send(method, *args, &block)
    end

    protected

    def tint(color, string)
      "\e[#{color}m#{string}\e[0m"
    end

    def colors
      { "F" => 31, "E" => 31, "S" => 33, "." => 32 }
    end

    def report
      MiniTest::Unit.runner.report
    end
  end
end

MiniTest::Unit.output = MiniTest::Colorize.new
