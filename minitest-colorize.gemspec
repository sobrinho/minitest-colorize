# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minitest/colorize/version"

Gem::Specification.new do |s|
  s.name        = "minitest-colorize"
  s.version     = Minitest::Colorize::VERSION
  s.authors     = ["Gabriel Sobrinho"]
  s.email       = ["gabriel.sobrinho@gmail.com"]
  s.homepage    = "https://github.com/sobrinho/minitest-colorize"
  s.summary     = %q{Colorize Minitest output and show failing tests instantly}
  s.description = %q{Colorize Minitest output and show failing tests instantly}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'minitest', '>= 5.2'
  s.add_development_dependency 'rake', '>= 0.8.7'
end
