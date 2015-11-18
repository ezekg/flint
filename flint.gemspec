# encoding: UTF-8

lib = File.expand_path "../lib/", __FILE__
$:.unshift lib unless $:.include? lib

require "flint"

Gem::Specification.new do |spec|

  # Info
  spec.version = Flint::VERSION

  # Details
  spec.name = "flint-gs"
  spec.rubyforge_project = "flint"
  spec.licenses = "MIT"
  spec.authors = ["Ezekiel Gabrielse"]
  spec.email = ["ezekg@yahoo.com"]
  spec.homepage = "http://flint.gs"

  # Description
  spec.summary = %q{A highly advanced Sass grid framework designed for rapid responsive development.}
  spec.description = %q{Flint is a highly advanced Sass grid framework designed for rapid responsive development.}

  # Library
  spec.files += Dir.glob("lib/**/*.*")

  # Sass
  spec.files += Dir.glob("stylesheets/**/*.*")

  # Other
  spec.files += ["LICENSE", "README.md"]

  # Test
  spec.test_files += Dir.glob("tests/**/*.*")

  # Dependencies
  spec.add_dependency "sass", "~> 3.4"
end
