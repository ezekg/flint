require "../lib/flint.rb"
require "rubygems"
require "bundler"

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
# disable_warnings = true

# Options
sass_options = {
	# For when working on Windows machines
	:unix_newlines => true
}

module Flint
  class Profiler

    @@t_then = Time.now
    @@t_now = Time.now

    def initialize(function, action, args = nil, env = nil)
      @function = function
      @action = action
      @args = args
      @env = env
      profile
    end

    def get_time
      @@t_now = Time.now
      t = (@@t_now.to_f - @@t_then.to_f) * 1000.0
      @@t_then = @@t_now
      @@t_total = t
      "\e[0;31m#{t.to_s}\e[0m".ljust(40)
    end

    def get_name
      case
      when @function.respond_to?(:name)
        @function.name
      else
        nil
      end
    end

    def get_args
      if @args.nil?
        nil
      else
        @args.to_s[1...@args.length-2]
      end
    end

    def get_env
      if @env
        original_filename = @env.options.fetch(:original_filename, "unknown file")
        filename = @env.options.fetch(:filename, "unknown file")
        "\e[0;33m#{File.basename(original_filename)}:#{File.basename(filename)}\e[0m".ljust(80)
      else
        "\e[0;33munknown file\e[0m".ljust(80)
      end
    end

    def get_action
      "\e[0;32m#{@action.to_s}\e[0m".ljust(40)
    end

    def get_caller
      "\e[0;34m#{get_name}\e[0m(\e[0;30m#{get_args}\e[0m)"
    end

    # Black:  \e[0;30m
    # Red:    \e[0;31m
    # Green:  \e[0;32m
    # Yellow: \e[0;33m
    # Blue:   \e[0;34m
    # Purple: \e[0;35m
    # Cyan:   \e[0;36m
    # White:  \e[0;37m
    def profile
      puts "#{get_env} | #{get_time} | #{get_action} | #{get_caller}"
      # exit if @@t_total > 100 && @action == :execute
    end
  end
end

class Sass::Tree::Visitors::Perform
  alias_method :visit_function_old, :visit_function

  def visit_function(node)
    Flint::Profiler.new node.dup, :create
    visit_function_old node
  end
end

class Sass::Script::Tree::Funcall
  alias_method :perform_sass_fn_old, :perform_sass_fn

  def perform_sass_fn(function, args, splat, environment)
    Flint::Profiler.new function.dup, :execute, args.dup, environment.dup
    perform_sass_fn_old function, args, splat, environment
  end
end

class Sass::Tree::Visitors::Perform < Sass::Tree::Visitors::Base

  # Removes all comments completely
  def visit_comment(node)
    return []
  end
end
