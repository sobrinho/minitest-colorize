require 'test_helper'

class MiniTest::ColorizeTest < MiniTest::Unit::TestCase
  def test_fail
    assert_output "\e[31mF\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'F'
    end
  end

  def test_error
    assert_output "\e[31mE\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'E'
    end
  end

  def test_skip
    assert_output "\e[33mS\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'S'
    end
  end

  def test_success
    assert_output "\e[32m.\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print '.'
    end
  end

  def test_others
    assert_output "colorize" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'colorize'
    end
  end

  def test_print_without_arguments
    assert_output '' do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print
    end
  end
end
