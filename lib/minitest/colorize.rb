require "minitest/colorize/version"

module Minitest
  class Colorize
    attr_reader :io

    def initialize(io = $stdout)
      @io = io
    end

    def sync
      @io.sync
    end

    def sync=(value)
      @io.sync = value if @io.respond_to?(:sync)
    end

    def print(string = nil)
      return io.print if string.nil?

      case string
      when 'E', 'F'
        io.print red(string)
      when 'S'
        io.print yellow(string)
      when '.'
        io.print green(string)
      else
        io.print string
      end
    end

    def puts(string = nil)
      return io.puts if string.nil?

      if string =~ /(\d+) runs, (\d+) assertions, (\d+) failures, (\d+) errors, (\d+) skips/
        if $3 != '0' || $4 != '0'
          io.puts red(string)
        elsif $5 != '0'
          io.puts yellow(string)
        else
          io.puts green(string)
        end
      else
        io.puts string.gsub(/\d+\) Skipped:/) { |o| yellow o }
                      .gsub(/\d+\) (?:Error|Failure):/) { |o| red o }
      end
    end

    def method_missing(method, *args, &block)
      io.send(method, *args, &block)
    end

    protected

    def color_enabled?
      io.tty?
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
  end
end

