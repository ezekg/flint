require "../lib/flint.rb"
require "rubygems"
require "bundler"

# Require dependencies through bundler
Bundler.require(:default, :test) if defined?(Bundler)

require "sass-prof"
prof             = SassProf::Config
# prof.output_file = "sass-prof.log"
# prof.quiet       = true
prof.max_width   = 40
prof.color       = true
prof.t_max       = 9000

# Define paths
css_dir = "output"
sass_dir = "input"

# Output style will change based on environment
output_style = :expanded

# Disable line comments
line_comments = false

# Disable Sass warnings
# disable_warnings = true

# Options
sass_options = {
	# For when working on Windows machines
	:unix_newlines => true
}
