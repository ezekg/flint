require '../lib/flint.rb'
require 'rubygems'
require 'bundler'

# Require dependencies through bundler
Bundler.require(:default, :test) if defined?(Bundler)

# Define paths
css_dir = "output"
sass_dir = "input"

# Output style will change based on environment
output_style = :expanded

# Disable line comments
line_comments = false

# Disable Sass warnings
disable_warnings = true

# Options
sass_options = {
	# For when working on Windows machines
	:unix_newlines => true
}

module Sass::Script::Functions
    @@timeStart = Time.now
    @@timeLast  = Time.now

    def profileRender(timeLast)
        diff = Time.now - timeLast
        return Sass::Script::String.new(diff * 1)
    end

    def timing_total()
        return self.profileRender(@@timeStart)
    end

    def timing_interval()
        str = profileRender(@@timeLast)
        @@timeLast = Time.now
        return str
    end
end
