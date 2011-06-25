require 'test_helper'

class MiniTest::ColorizeTest < MiniTest::Unit::TestCase
  def test_print_fail
    assert_output "\e[31mF\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'F'
    end
  end

  def test_print_error
    assert_output "\e[31mE\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'E'
    end
  end

  def test_print_skip
    assert_output "\e[33mS\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print 'S'
    end
  end

  def test_print_success
    assert_output "\e[32m.\e[0m" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.print '.'
    end
  end

  def test_print
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

  def test_puts_fail
    assert_output "\e[31m12 tests, 12 assertions, 4 failures, 0 errors, 0 skips\e[0m\n" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.puts '12 tests, 12 assertions, 4 failures, 0 errors, 0 skips'
    end
  end

  def test_puts_error
    assert_output "\e[31m12 tests, 12 assertions, 0 failures, 4 errors, 0 skips\e[0m\n" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.puts '12 tests, 12 assertions, 0 failures, 4 errors, 0 skips'
    end
  end

  def test_puts_skip
    assert_output "\e[33m12 tests, 12 assertions, 0 failures, 0 errors, 4 skips\e[0m\n" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.puts '12 tests, 12 assertions, 0 failures, 0 errors, 4 skips'
    end
  end

  def test_puts_success
    assert_output "\e[32m12 tests, 12 assertions, 0 failures, 0 errors, 0 skips\e[0m\n" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.puts '12 tests, 12 assertions, 0 failures, 0 errors, 0 skips'
    end
  end

  def test_puts
    assert_output "colorize\n" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.puts 'colorize'
    end
  end

  def test_puts_without_arguments
    assert_output "\n" do
      colorize = MiniTest::Colorize.new($stdout)
      colorize.puts
    end
  end
end
