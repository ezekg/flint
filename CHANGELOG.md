# Change Log

### 2.3.7
* Fix issue with Rails integration

### 2.3.4, 2.3.6
* Fix compatibility issues with Libsass
* Refactor and get rid of various functions

### 2.3.2, 2.3.3
* Fix deprecation warning for multiline strings

### 2.3.1
* Fix issue where grid overlay wasn't applied using `@at-root`

### 2.3.0
* Add SVG grid overlay to `debug-mode`.

### 2.2.0
* Rewrite `exists()` method in Ruby for a huge performance increase.
* Write `Flint::Profiler` to help test future performance bottlenecks.
* Update global variables to follow standard naming conventions.

### 2.1.4
* Fix issue with using `unquote()` on non-strings.

### 2.1.2, 2.1.3
* Update comments to follow SassDoc standards.
* Small style fixes.

### 2.1.1
* Fix issue with unassigned `$output-width` variable when using `$span: 0`.

### 2.1.0
* Added support for `rem` values.
* Set up proper submodule for Bootcamp.

### 2.0.9
* Fixed issue with `$gutter: center` attempting to divide by `auto`.
* Wrote tests for `$gutter` modifiers.

### 2.0.7, 2.0.8 10/17/14
* Changed doc comments from `/* */` comments to `///`.

### 2.0.6 10/7/14
* Remove redundant Ruby functions.
* Update docs to include examples that follow SassDoc standards.

### 2.0.5 10/4/14
* Update docs

### 2.0.4 10/3/14
* Refactored Ruby `lib` for easier upkeep.
* Removed `@content` from doc blocks for now.
* Added `list_to_string()` Ruby function.
* Fixed issue with `support-syntax-bem()` returning oddly quoted strings when using Sass functions.

### 2.0.3 10/2/14
* Update documentation to follow SassDoc standards.

### 2.0.2 10/1/14
* Reversed order that `map-merge` merges instance maps, so that newer instances are merged to the top rather than the bottom. Increased performance benchmarks by `23%`.
* Added Ruby function for `map-fetch()`. Increased performance benchmarks by `15%`.
* Updated main API mixin `_()` to follow SassDoc standards.

### 2.0.1 - 9/25/14
* Updated Sass dependency to `~> 3.4` in gemspec.
* Ignore `test` folder in bower.

### 2.0.0 - 9/25/14
* Release `2.0.0`!

### 2.0.0.rc.4 - 9/17/14
* Added ability to use na identical `$context` value with a variable `$span`. Example, `_(1 2 3 4, 4)`.

### 2.0.0.rc.3 - 9/16/14
* Fixed issue with `$context` modifiers calling a division by 0.

### 2.0.0.rc.1 - 9/12/14
* Revamped codebase considerably.
* Modified layout of `$flint` configuration map. Breakpoints are now housed in their own separate section.
* Removed `$shift` modifier. _(Don't like this one? Create an issue and let me know!)_
* Modified calculations to use fixed values all the way through the system, and then convert to percentages on output. Coupled with instance methods, this makes gutters infinitely nest-able and consistent even on fluid grids.
* Added `instance-maps` option in config to enable or disable instance maps and all of the associated methods.
* Modified docblocks to follow [SassDoc](https://github.com/SassDoc/sassdoc) standards.
* Moved selector functions over to Sass 3.4. _(No more forced Ruby dependency!)_
* Modified tests; added new HTML test page.
* _Lots of other cleanup and speed improvements._

### 1.12.0 - 8/29/14
* Added test suite and contributing guidelines.
* Cleaned up a few functions.

### 1.11.2 - 8/13/14
* Rewrite `flint-map-fetch()` and `flint-exists()` functions.
* Add ability to call `@include _(<alias>, container)` for individual breakpoints.
* Add ability to call `@include _(container, clear)` & `@include _(<alias>, container, clear)` consecutively.
* Fix breakpoint query math for fixed `em` grids.

### 1.10.0 - 8/11/14
* Add `$gutter: center` modifier.
* Fix `SASS_PATH` issue.

### 1.9.1 - 8/4/14
* Break Compass dependency. _(Will completely break in `2.0` when dependence on Ruby functions cease)._
* Add better error handling for invalid arguments.

### 1.8.0 - 8/1/14
* Deprecated `$shift` modifier.
* Optimized `for` query to output comma delimited list of queries instead of duplicating styles for each query.
* Optimized `_main.scss`. Significantly cleaned up code by grouping like-calls together into the same conditional.
* Removed prefixes from all properties.
* Created `flint-box-sizing` mixin. Uses `box-sizing` mixin if it exists.
* Removed `only screen` from media queries.

### 1.7.2 - 7/14/14
* Removed `string-to-number` functions and all dependencies associated with them.

### 1.7.1 - 7/12/14
* Fixed issue with `debug mode` defaulting to true.

### 1.7.0 - 7/11/14
* Added Ruby functions to help with performance.
* Added various memoization functions to help with performance.
* Prefixed all functions and mixins with `flint-` to ensure compatibility with other plugins.
* Cleaned up code in `calculate.scss`.

### 1.6.5 - 7/08/14
* Fixed issue with `flint-support-syntax-bem` function.

### 1.6.4 - 7/08/14
* Remove recursive option from `flint-str-replace` for performance reasons.

### 1.6.3 - 7/08/14
* Added string flint-replace function.
    * Modified way BEM selectors are parsed with new function.
* Removed `@dependance` declaratons from doc blocks.

### 1.6.2 - 7/07/14
* Added warnings for improper arguments for various mixins and functions.
* Slightly changed doc blocks.

### 1.6.1 - 7/03/14
* Added functions for syntax-support that are easily extendable
    * Added syntax support option in config
    * Added offical support for BEM syntax
* Fix minor issue with `$context: auto` conditional in `main.scss`

### 1.6.0 - 6/30/14
* Add feature to pass arbitrary values to media query calls.
* Fix issue with max-width conditional.
* Clean up codebase. Add `flint-types-in-list()` function.

### 1.5.0 - 6/26/14
* Default config is now in ems instead of pixels.
* Fixed issues with breakpoint calculations when using ems. Should successfully break at the correct points when using alias conditionals and not be `~0.0625em` off.
* Added warn directives when common mistakes occur.
* Cleaned up doc blocks.

### 1.4.0 - 6/11/14
* Cleaning house. Cleaned up function definitions and documentation, quoted all strings, and overall just made the code more tidy.

### 1.3.4 - 5/20/14
* Fixed issue with `(for x y z)` loop not outputting correct breakpoints due to an invalid if statement.

### 1.3.3 - 5/19/14
* Fixed issue with comma seperated parent selectors causing errors and other issues.
    * Added small clean up functions for comma seperated selector strings for various functions.

### 1.3.2 - 5/16/14
* Added `$context: auto` for fixed grids. It will automatically get the parent instance's width, and calculate on that instead of the base breakpoint. This fixes issues where parents couldn't contain children of the same span, and the further you would nest, the worse the issue would get.

### 1.3.1 - 5/14/14
* Fixed issue with `_(greater than y)` not outputting the correct calculations on `fixed` grids
    * Issue was that when you used for example: `_(greater than laptop)`, `laptop` would actually be included, instead of ommitted. It now acts as 'anything above laptops breakpoint', the same way `less than y` works.
* Adjusted the way breakpoints are calculated for easier modifications moving forward.
* Optimized `flint-calc-breakpoint()` function

### 1.3.0 - 5/09/14
* Added ability to pass an abitrary `$context` while maintaining a consistent gutter
* Small changes to `debug-mode`
    * Added parent instance selector to output
    * Added actual `$context` in place of `auto` in output

### 1.2.2 - 5/02/14
* Adjusted `$length` variable in `flint-str-to-list()` for better performance.
* Added 2 additional aliases for `$gutter` modifiers
    * `alpha > first`
    * `omega > flint-last`

### 1.2.1 - 4/30/14
* Fixed issue with comma separated child selectors throwing an error. `Fixes #5`

### 1.2.0 - 4/25/14
* Added aliases for `$gutter` modifiers
    * `null > default | regular | normal`
    * `alpha > no-left`
    * `omega > no-right`
    * `row > none`
* Removed option for `gutter: false` in config. Use `0(unit)` from now on.

### 1.1.0 - 4/24/14
* Added `$gutter: inside` modifier
* Adjusted `$span: 0` to hide element instead of compiling with no width
* Corrected small issue with `less than x`, `greater than x` on fixed grids
* Cleaned up variable/function names
* Added detailed comments to all mixins/functions
* Built `.gemspec` so that Flint can be installed via `gem install flint-gs`
* Added `bower.json` so that Flint can be installed via Bower
* Organized file structure by splitting functions/mixins into separate files for easier modifications/version control moving forward.
* You can now take advantage of both `$shift` and `$gutter` modifiers together.

### 1.0.0 - 4/11/14
* You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a container element actually exists or you'll get some weird output, or none at all. Pretty cool feature utilizing the new `instance` map, which keeps track of every `instance` of the `_()` mixin, and saves all the tasty variables for use-cases like this.
