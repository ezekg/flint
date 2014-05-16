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
  s.homepage = "https://github.com/ezekg/flint/"

  # Project Description
  s.summary = %q{A powerful Sass grid-system designed for complex responsive layouts.}
  s.description = %q{Flint is designed to be a flexible layout toolkit that developers can use for any responsive grid-based project.}

  # Library Files
  s.files += Dir.glob("lib/**/*.*")

  # Sass Files
  s.files += Dir.glob("stylesheets/**/*.*")

  # Template Files
  # s.files += Dir.glob("templates/**/*.*")

  # Other files
  s.files += ["LICENSE", "README.md"]

  # Gem Bookkeeping
  s.required_rubygems_version = ">= 1.3.6"
  s.rubygems_version = %q{1.3.6}

  # Gems Dependencies
  s.add_dependency("sass", [">=3.3.0"])
  s.add_dependency("compass", [">= 0.12.1"])

end