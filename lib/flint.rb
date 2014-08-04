require 'sass'

base_directory = File.expand_path(File.join(File.dirname(__FILE__), '..'))
flint_stylesheets_path = File.join(base_directory, 'sass')

if (defined? Compass)
    Compass::Frameworks.register('flint', :path => base_directory)
else
    # Compass not found, register on the Sass path via the environment
    if ENV.has_key?("SASS_PATH")
        ENV["SASS_PATH"] = ENV["SASS_PATH"] + File::PATH_SEPARATOR + flint_stylesheets_path
    else
        ENV["SASS_PATH"] = flint_stylesheets_path
    end
end

# Date is in the form of YYYY-MM-DD
module Flint
    VERSION = "1.9.1"
    DATE = "2014-08-04"
end

# Custom functions
module Sass::Script::Functions

    # Use ruby functions
    # ----
    def flint_use_ruby()
        Sass::Script::Bool.new(true)
    end

    # Returns stringified selector
    # ----
    # @return [string]
    def selector_string()
        Sass::Script::String.new(environment.selector.to_s)
    end

    # Turns string into a flat list
    # ----
    # @param string [string] : string
    # @param separator [string] : item to find which separates substrings
    # @param ignore [string] : removes remaining string beyond item
    # ----
    # @return [list] | error
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

    # Replace substring
    # ----
    # @param string [string] : string that contains substring
    # @param find [string] : substring to replace
    # @param replace [string] : new string to replace sub with
    # ----
    # @return [string]
    def replace_substring(string, find, replace)
        # Assert types
        assert_type string, :String
        assert_type find, :String
        assert_type replace, :String
        # Return new string
        Sass::Script::String.new(string.value.gsub(find.value, replace.value))
    end

    declare :string_to_list, [:string, :separator, :ignore]
    declare :replace_substring, [:string, :find, :replace]

end
