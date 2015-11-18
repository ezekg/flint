# encoding: UTF-8

lib = File.expand_path "../../lib/", __FILE__
$:.unshift lib unless $:.include? lib

require "sass"

require "flint/version"
require "flint/functions"

base_directory = File.expand_path(File.join(File.dirname(__FILE__), '..'))
flint_stylesheets_path = File.join(base_directory, 'stylesheets')

if (defined? Compass)
  Compass::Frameworks.register('flint', :path => base_directory)
else
  ENV["SASS_PATH"] = [ENV["SASS_PATH"], flint_stylesheets_path].compact.join(File::PATH_SEPARATOR)
end

module Flint
  Sass::Script::Functions.send(:include, Flint)
end
