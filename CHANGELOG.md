# Change Log

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
* Remove recursive option from `flint-replace-substring` for performance reasons.

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
* Fixed issues with breakpoint calculations when using ems. Should successfully break at the correct points when using alias conditionals and not be ~0.0625em off.
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
* Added `$context: auto` to for fixed grids. It will automatically get the parent instance's width, and calculate on that instead of the base breakpoint.
    * This fixes issues where parents couldn't contain children of the same span, and the further you would nest, the worse the issue would get.

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
* Adjusted `$length` variable in `flint-string-to-list()` for better performance.
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
* You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a container element actually flint-exists or you'll get some weird output, or none at all. Pretty cool feature utilizing the new `instance` map, which keeps track of every `instance` of the `_()` mixin, and saves all the tasty variables for use-cases like this.
