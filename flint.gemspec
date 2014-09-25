require './lib/flint'

Gem::Specification.new do |s|

  # Release Specific Information
  s.version = Flint::VERSION
  s.date = Flint::DATE

  # Gem Details
  s.name = "flint-gs"
  s.rubyforge_project = "flint"
  s.licenses = ['MIT']
  s.authors = ["Ezekiel Gabrielse"]
  s.email = ["ezekg@yahoo.com"]
  s.homepage = "http://flint.gs"

  # Project Description
  s.summary = %q{A highly advanced Sass grid framework designed for rapid responsive development.}
  s.description = %q{Flint is a highly advanced Sass grid framework designed for rapid responsive development.}

  # Library Files
  s.files += Dir.glob("lib/**/*.*")

  # Sass Files
  s.files += Dir.glob("stylesheets/**/*.*")

  # Test Files
  # s.files += Dir.glob("tests/**/*.*")

  # Other files
  s.files += ["LICENSE", "README.md"]

  # Gem Bookkeeping
  s.required_rubygems_version = ">= 1.3.6"
  s.rubygems_version = %q{1.3.6}

  # Gems Dependencies
  s.add_dependency("sass", ["~> 3.4"])
  # s.add_dependency("compass", [">= 0.12.1"])

end
