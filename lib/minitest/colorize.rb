require "minitest/colorize/version"
require "minitest/unit"

module MiniTest
  class Colorize
    attr_accessor :io

    def initialize(io)
      self.io = io
    end

    def print(string = nil)
      return io.print if string.nil?

      if color = colors[string]
        io.print tint(color, string)
      else
        io.print string
      end

      unless report.empty?
        io.puts
        io.puts
        io.puts report.shift
        io.puts
      end
    end

    def puts(string = nil)
      return io.puts if string.nil?
      io.sync = true
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

        io.puts tint(color, string)
      else
        io.puts string
      end
    end

    def method_missing(method, *args, &block)
      io.send(method, *args, &block)
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

MiniTest::Unit.output = MiniTest::Colorize.new(MiniTest::Unit.output)
