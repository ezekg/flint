require 'sass'

base_directory = File.expand_path(File.join(File.dirname(__FILE__), '..'))
flint_stylesheets_path = File.join(base_directory, 'stylesheets')

if (defined? Compass)
    Compass::Frameworks.register('flint', :path => base_directory)
else
    ENV["SASS_PATH"] = [ENV["SASS_PATH"], flint_stylesheets_path].compact.join(File::PATH_SEPARATOR)
end

module Flint
    VERSION = "2.0.3"
    DATE = "2014-10-02"
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
    # Fetch value from map
    #
    # @param {Map}     map  - map to fetch value from
    # @param {ArgList} keys - list of keys to traverse
    #
    # @return {*}
    ###
    def flint_ruby_map_fetch(map, *keys)
        assert_type map, :Map, :map
        result = map
        keys.each {|key| result != nil ? result = result.to_h.fetch(key, nil) : break}
        return result != nil ? result : Sass::Script::Bool.new(false)
    end
    declare :flint_ruby_map_fetch, :args => [:map, :keys], :var_args => true

    ###
    # Turn string into a flat list
    #
    # @param {String} string    - string to operate on
    # @param {String} separator - item to find which separates substrings
    # @param {String} ignore    - removes remaining string beyond item
    #
    # @return {List}
    ###
    def flint_ruby_string_to_list(string, separator, ignore)
        assert_type string, :String, :string
        assert_type separator, :String, :separator
        assert_type ignore, :String, :ignore
        # Remove everything after ignore, split with separator
        items = string.value[/[^#{ignore}]+/].split(separator.value)
        if items.count == 1
            Sass::Script::String.new(items[0], :comma)
        else
            Sass::Script::List.new(items.map { |i| Sass::Script::String.new(i) }, :comma)
        end
    end
    declare :flint_ruby_string_to_list, :args => [:string, :separator, :ignore]

    ###
    # Replace substring with string
    #
    # @param {String} string  - string that contains substring
    # @param {String} find    - substring to replace
    # @param {String} replace - new string to replace sub with
    #
    # @return {String}
    ###
    def flint_ruby_replace_substring(string, find, replace)
        assert_type string, :String, :string
        assert_type find, :String, :find
        assert_type replace, :String, :replace
        Sass::Script::String.new(string.value.gsub(find.value, replace.value))
    end
    declare :flint_ruby_replace_substring, :args => [:string, :find, :replace]

end
