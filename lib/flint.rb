require 'sass'

base_directory = File.expand_path(File.join(File.dirname(__FILE__), '..'))
flint_stylesheets_path = File.join(base_directory, 'stylesheets')

if (defined? Compass)
    Compass::Frameworks.register('flint', :path => base_directory)
else
    ENV["SASS_PATH"] = [ENV["SASS_PATH"], flint_stylesheets_path].compact.join(File::PATH_SEPARATOR)
end

module Flint
    VERSION = "2.0.0.rc.4"
    DATE = "2014-09-17"
end

module Sass::Script::Functions

    ###
    # Use ruby functions
    #
    # @return {Bool}
    ###
    def flint_use_ruby()
        Sass::Script::Bool.new(true)
    end

    ###
    # Turns string into a flat list
    #
    # @param {String} string    - string
    # @param {String} separator - item to find which separates substrings
    # @param {String} ignore    - removes remaining string beyond item
    #
    # @return {List}
    ###
    def string_to_list(string, separator, ignore)
        # Remove rest of string after ignore
        ignore = string.value[/[^#{ignore}]+/]
        # Get first set of strings, convert to array by separator
        items = ignore.split(separator.value)
        # Convert array to list
        if items.count == 1
            Sass::Script::String.new(items[0], :comma)
        else
            Sass::Script::List.new(items.map { |i| Sass::Script::String.new(i) }, :comma)
        end
    end

    ###
    # Replace substring
    #
    # @param {String} string  - string that contains substring
    # @param {String} find    - substring to replace
    # @param {String} replace - new string to replace sub with
    #
    # @return {String}
    ###
    def replace_substring(string, find, replace)
        Sass::Script::String.new(string.value.gsub(find.value, replace.value))
    end

    declare :string_to_list, [:string, :separator, :ignore]
    declare :replace_substring, [:string, :find, :replace]

end
