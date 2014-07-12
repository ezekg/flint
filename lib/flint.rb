require 'compass'

extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('flint', :path => extension_path)

#  Date is in the form of YYYY-MM-DD
module Flint
    VERSION = "1.7.1"
    DATE = "2014-07-12"
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

    # Converts string to number
    # ----
    # @param string [string] : string
    # ----
    # @return [number]
    def string_to_number(string)
        Sass::Script::Number.new(string.value.to_i)
    end

    declare :string_to_list, [:string, :separator, :ignore]
    declare :replace_substring, [:string, :find, :replace]
    declare :string_to_number, [:string]

end
