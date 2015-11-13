module Flint

  def self.declare(*args)
    Sass::Script::Functions.declare(*args)
  end

  #
  # Use ruby functions
  #
  # @return {Bool}
  #
  def flint_use_ruby()
    Sass::Script::Bool.new(true)
  end

  #
  # Fetch value from map
  #
  # @param {Map}     map  - map to fetch value from
  # @param {ArgList} keys - list of keys to traverse
  #
  # @return {*}
  #
  def flint_ruby_map_fetch(map, *keys)
    assert_type map, :Map, :map

    result = map
    keys.each { |key| result.nil? ? break : result = result.to_h.fetch(key, nil) }

    unless result.nil?
      result
    else
      Sass::Script::Bool.new(false)
    end
  end
  declare :flint_ruby_map_fetch, :args => [:map, :keys], :var_args => true

  #
  # Joins all elements of list with passed glue
  #
  # @param {List}   list
  # @param {String} glue
  #
  # @return {String}
  #
  def flint_ruby_list_to_str(list, glue)
    assert_type list, :List, :list
    assert_type glue, :String, :glue

    arr = list.to_a.flatten.map { |item| item.value }

    Sass::Script::String.new(arr.join(glue.value))
  end
  declare :flint_ruby_list_to_str, :args => [:list, :glue]

  #
  # Turn string into a flat list
  #
  # @param {String} string    - string to operate on
  # @param {String} separator - item to find which separates substrings
  # @param {String} ignore    - removes remaining string beyond item
  #
  # @return {List}
  #
  def flint_ruby_str_to_list(string, separator, ignore)
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
  declare :flint_ruby_str_to_list, :args => [:string, :separator, :ignore]

  #
  # Replace substring with string
  #
  # @param {String} string  - string that contains substring
  # @param {String} find    - substring to replace
  # @param {String} replace - new string to replace sub with
  #
  # @return {String}
  #
  def flint_ruby_str_replace(string, find, replace)
    assert_type string, :String, :string
    assert_type find, :String, :find
    assert_type replace, :String, :replace

    Sass::Script::String.new(string.value.gsub(find.value, replace.value))
  end
  declare :flint_ruby_str_replace, :args => [:string, :find, :replace]

end
