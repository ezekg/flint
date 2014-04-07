require 'sass'

module Sass::Script::Functions
	
	def selector_string()
		return Sass::Script::String.new(environment.selector.to_s)
	end

end