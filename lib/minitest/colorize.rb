require "minitest/colorize/version"

module MiniTest
  class Colorize
    attr_accessor :io

    def initialize(io)
      self.io = io
    end

    def print(out)
      if color = colors[out]
        io.print "#{color}#{out}#{clear}"
      else
        io.print out
      end
    end

    def colors
      { "F" => "\e[31m", "E" => "\e[31m", "S" => "\e[33m", "." => "\e[32m" }
    end

    def clear
      "\e[0m"
    end

    def method_missing(method, *args, &block)
      io.send(method, *args, &block)
    end
  end
end

MiniTest::Unit.output = MiniTest::Colorize.new(MiniTest::Unit.output)
