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

    def initialize(node, action, args = nil)
      @action = action
      @args = args

      case
      when node.respond_to?(:name)
        @node = node.name
      else
        return
      end

      profile
    end

    def get_time
      @@t_now = Time.now
      t = (@@t_now.to_f - @@t_then.to_f) * 1000.0
      @@t_then = @@t_now
      t.to_s
    end

    def profile
      puts "\e[0;31m#{get_time.ljust(20)}\e[0m \e[0;32m#{@action.to_s}\e[0m #{@node}(\e[0;30m#{@args}\e[0m)"
    end
  end
end

class Sass::Tree::Visitors::Perform
  alias_method :visit_function_old, :visit_function

  def visit_function(node)
    Flint::Profiler.new node, :create
    visit_function_old node
  end
end

class Sass::Script::Tree::Funcall
  alias_method :perform_sass_fn_old, :perform_sass_fn

  def perform_sass_fn(function, args, splat, environment)
    Flint::Profiler.new function, :execute, args
    perform_sass_fn_old function, args, splat, environment
  end

  # alias_method :_perform_old, :_perform
  #
  # def _perform(environment)
  #   Flint::Profiler.new @name, :perform
  #   _perform_old environment
  # end
end

class Sass::Tree::Visitors::Perform < Sass::Tree::Visitors::Base

  # Removes all comments completely
  def visit_comment(node)
    return []
  end
end
