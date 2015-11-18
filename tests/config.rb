require "../lib/flint.rb"
require "rubygems"
require "bundler"

Bundler.require(:default, :test) if defined?(Bundler)

# require "sass-prof"
# prof             = SassProf::Config
# prof.output_file = "sass-prof.log"
# prof.quiet       = false
# prof.max_width   = 40
# prof.color       = true
# prof.t_max       = 90000
# prof.ignore      = [:var]

css_dir       = "output"
sass_dir      = "input"
output_style  = :expanded
line_comments = false
sass_options  = {
  :unix_newlines => true
}
