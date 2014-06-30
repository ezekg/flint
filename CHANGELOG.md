# Change Log

### 6/30/14
* Add feature to pass arbitrary values to media query calls.
* Fix issue with max-width conditional.
* Clean up codebase. Add `types-in-list()` function.

### 6/26/14
* Default config is now in ems instead of pixels.
* Fixed issues with breakpoint calculations when using ems. Should successfully break at the correct points when using alias conditionals and not be ~1em off.
* Added warn directives when common mistakes occur.
* Cleaned up doc blocks.

### 6/11/14
* Cleaning house. Cleaned up function definitions and documentation, quoted all strings, and overall just made the code more tidy.

### 5/20/14
* Fixed issue with `(for x y z)` loop not outputting correct breakpoints due to an invalid if statement.

### 5/19/14
* Fixed issue with comma seperated parent selectors causing errors and other issues.
    * Added small clean up functions for comma seperated selector strings for various functions.

### 5/16/14
* Added `$context: auto` to for fixed grids. It will automatically get the parent instance's width, and calculate on that instead of the base breakpoint.
    * This fixes issues where parents couldn't contain children of the same span, and the further you would nest, the worse the issue would get.

### 5/14/14
* Fixed issue with `_(greater than y)` not outputting the correct calculations on `fixed` grids
    * Issue was that when you used for example: `_(greater than laptop)`, `laptop` would actually be included, instead of ommitted. It now acts as 'anything above laptops breakpoint', the same way `less than y` works.
* Adjusted the way breakpoints are calculated for easier modifications moving forward.
* Optimized `calc-breakpoint()` function

### 5/09/14
* Added ability to pass an abitrary `$context` while maintaining a consistent gutter
* Small changes to `debug-mode`
    * Added parent instance selector to output
    * Added actual `$context` in place of `auto` in output

### 5/02/14
* Adjusted `$length` variable in `string-to-list()` for better performance.
* Added 2 additional aliases for `$gutter` modifiers
    * `alpha > first`
    * `omega > last`

### 4/30/14
* Fixed issue with comma separated child selectors throwing an error. `Fixes #5`

### 4/25/14
* Added aliases for `$gutter` modifiers
    * `null > default | regular | normal`
    * `alpha > no-left`
    * `omega > no-right`
    * `row > none`
* Removed option for `gutter: false` in config. Use `0(unit)` from now on.

### 4/24/14
* Added `$gutter: inside` modifier
* Adjusted `$span: 0` to hide element instead of compiling with no width
* Corrected small issue with `less than x`, `greater than x` on fixed grids
* Cleaned up variable/function names
* Added detailed comments to all mixins/functions

### 4/18/14
* Built `.gemspec` so that Flint can be installed via `gem install flint-gs`
* Added `bower.json` so that Flint can be installed via Bower
* Organized file structure by splitting functions/mixins into separate files for easier modifications/version control moving forward.

### 4/12/14
* You can now take advantage of both `$shift` and `$gutter` modifiers together.

### 4/11/14
* You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a container element actually exists or you'll get some weird output, or none at all. Pretty cool feature utilizing the new `instance` map, which keeps track of every `instance` of the `_()` mixin, and saves all the tasty variables for use-cases like this.
