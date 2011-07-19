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

      case string
      when 'E', 'F'
        stream.print red(string)
      when 'S'
        stream.print yellow(string)
      when '.'
        stream.print green(string)
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
        if $3 != '0' || $4 != '0'
          stream.puts red(string)
        elsif $5 != '0'
          stream.puts yellow(string)
        else
          stream.puts green(string)
        end
      else
        stream.puts string
      end
    end

    def method_missing(method, *args, &block)
      stream.send(method, *args, &block)
    end

    protected

    def color_enabled?
      stream.tty?
    end

    def tint(color, string)
      if color_enabled?
        "\e[#{color}m#{string}\e[0m"
      else
        string
      end
    end

    def red(string)
      tint(31, string)
    end

    def green(string)
      tint(32, string)
    end

    def yellow(string)
      tint(33, string)
    end

    def report
      MiniTest::Unit.runner.report
    end
  end
end

MiniTest::Unit.output = MiniTest::Colorize.new
