require 'compass'
extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('flint', :path => extension_path)

#  Version is a number. If a version contains alphas, it will be created as a prerelease version
#  Date is in the form of YYYY-MM-DD
module Flint
  VERSION = "1.6.2"
  DATE = "2014-07-03"
end

# Custom functions
module Sass::Script::Functions
	def selector_string()
		return Sass::Script::String.new(environment.selector.to_s)
	end
end
