[![Flint - Grid System](http://flint.gs/wp-content/themes/flint/images/logo.png)](http://flint.gs)

[![Gem Version](https://badge.fury.io/rb/flint-gs.svg)](http://badge.fury.io/rb/flint-gs)

Flint is a responsive grid system written in Sass, created to allow developers to rapidly produce responsive layouts that are built on a sophisticated foundation. Being a designer myself, a large amount of time was spent on the syntax itself. Flint is very unique in the fact that it uses only a single mixin for all output: `_( )`. Yes, it really is just simply an underscore. Easy to remember, huh? It shoves the function mumbo-jumbo out of the way and allows us to focus on the aspect that matters most: the layout. [Check out this short introduction over at Sitepoint.com](http://www.sitepoint.com/rapid-responsive-development-sass-flint/).

Take it for a spin on [SassMeister.com](http://sassmeister.com/gist/228449011362bcdfe38c)!

Enjoy.

## Table of Contents

1. [Requirements](#requirements)
1. [Installation](#installation)
1. [Documentation](#documentation)
	* [Config](#config)
	* [Foundation](#foundation)
	* [Container](#container)
	* [Clearfix](#clear)
	* [Recursive shorthand](#recursive-shorthand)
	* [Recursive shorthand with identical context](#recursive-shorthand-with-identical-context)
	* [Recursive shorthand with variable context](#recursive-shorthand-with-variable-context)
	* [Variable shorthand](#variable-shorthand)
	* [Variable shorthand with context](#variable-shorthand-with-context)
	* [Wrapping in media queries](#wrapping-in-media-queries)
	* [Call by alias](#call-by-alias)
	* [Gutter modifiers](#gutter-modifiers)
1. [Syntax support](#syntax-support)
1. [Support](#support)
1. [Authors](#authors)
1. [License](#license)

## Requirements

* Sass ~> `3.4.0`

## Installation

1. Install via Ruby `gem install flint-gs`, or Bower `bower install flint --save-dev`
2. If you're using Compass, add `require "flint"` to your `config.rb`
3. Import it into your stylesheet with `@import "flint"`

If you're not using Compass, you can require the custom Ruby functions and compile via:
```
scss --require ./lib/flint.rb example.scss > example.css
```

## Documentation

### Config

Getting up and running with Flint is simple: you can either configure your own grid, or use the default grid setup that ships with Flint. Being able to quickly configure a grid was at the forefront of my goals when developing Flint; and so it offers an immense configuration map, which is essentially a Sass map of all your project’s grid settings and breakpoints. You don’t have to mess with endless variables just to get your project up and running. Instead, you just create a single variable called `$flint`:

##### Usage

To begin, you can either use the default `config` (below) which comes baked in, or you can define your own using the `$flint` variable, using the default config as a template. Settings may be entered in `px` or `em`, and Flint will do the rest. One of the immediate advantages of using Flint is that it allows you to create an unlimited number of breakpoints for your project, with any alias that you want. If you like to call your breakpoints crazy names like ‘high-tide’ or ‘ex-presidents’, that’s completely fine with me.

*Keep in mind, whatever unit you choose to use here needs to be used consistently throughout Flint. No mixing of `px` and `em` units. Also, Flint does require that you follow a `DESC` order for your breakpoint configuration, this way it can traverse the config map correctly to output valid media queries.*

```scss
/**
* Configuration map
*
* @prop {Map}    breakpoints                  - map of breakpoints, follow DSC order
* @prop {Map}    breakpoints.alias            - named map of breakpoint settings
* @prop {Number} breakpoints.alias.columns    - column count for breakpoint
* @prop {Number} breakpoints.alias.breakpoint - breakpoint value for breakpoint
* @prop {Map}    settings                     - map of settings for grid
* @prop {String} settings.default             - alias of breakpoint to be grid default
* @prop {String} settings.grid                - type of grid
* @prop {Number} settings.gutter              - value for gutter
* @prop {String} settings.float-direction     - direction of float
* @prop {Bool}   settings.max-width           - maximum width value
* @prop {Bool}   settings.max-width           - maximum width value
* @prop {Bool}   settings.center-container    - center containers
* @prop {Bool}   settings.border-box-sizing   - use `box-sizing: border-box`
* @prop {Bool}   settings.instance-maps       - use instance maps for added features
* @prop {Bool}   settings.support-syntax      - support syntax within instance functions
* @prop {Bool}   settings.debug-mode          - enable debug mode
*/
$flint: (
	"breakpoints": (
		"desktop": (
			"columns": 16,
			"breakpoint": 80em
		),
		"laptop": (
			"columns": 12,
			"breakpoint": 60em
		),
		"tablet": (
			"columns": 8,
			"breakpoint": 40em
		),
		"mobile": (
			"columns": 4,
			"breakpoint": 20em
		)
	),
	"settings": (
		"default": "mobile",
		"grid": "fluid",
		"gutter": 0.625em,
		"float-direction": "left",
		"max-width": true,
		"center-container": true,
		"border-box-sizing": true,
		"instance-maps": true,
		"support-syntax": false,
		"debug-mode": false
	)
) !default;
```

### Foundation

_Flint will attempt to use a local box-sizing mixin named `box-sizing`. If one is not found, it will use it's own._

A foundation instance will output a global `box-sizing: border-box` declaration. If you selected `"border-box-sizing": true`, then it is *advised* to create a global foundation instance.

```scss
@include _(foundation);
```

This way your output won't be riddled with `box-sizing` declarations every time you define a span. This will automatically output the rules onto the global selector `*`. In the future this might be automatic, but for now I'll keep it manual.

### Container

Containers act as a row for each individual breakpoint, and if set in your config, uses a max-width. They do not float, so if you have `"center-container"` set to `true` then it will also center your element using `auto` left and right margins.

```scss
.container {
	@include _(container);
}
```

Outputs,
```scss
.container {
	display: block;
	float: none;
	width: 100%;
	max-width: 1280px
	margin-right: auto;
	margin-left: auto;
}
```

You may also define a container for a specific breakpoint, `@include _(desktop, container)`, as well as chain a clearfix and container call together with `@include _(container, clear)` or `@include _(<alias>, container, clear)`.

### Clear

_Flint will attempt to use a local clearfix mixin named `clearfix`. If one is not found, it will use it's own._

Given that Flint is float based, you might find yourself needing to use a clearfix. Flint comes packaged with a micro-clearfix function.

```scss
.clear {
	@include _(clear);
}
```

Outputs,
```scss
.clear {
	zoom: 1;
}
.clear:before, .clear:after {
	content: "\0020";
	display: block;
	height: 0;
	overflow: hidden;
}
.clear:after {
	clear: both;
}
```

### Recursive shorthand

Use this if you want *identical* column spans across all breakpoints.

```scss
.recursive {
	@include _(3);
}
```

Outputs, *(with debug mode on)*
```scss
.recursive {
  display: block;
  float: left;
  width: 17.1875%;
  margin-right: 0.78125%;
  margin-left: 0.78125%;
  -flint-instance-count: 1;
  -flint-parent-instance: none;
  -flint-key: desktop;
  -flint-breakpoint: 1280px;
  -flint-columns: 16;
  -flint-span: 3;
  -flint-context: null;
  -flint-gutter: null;
  -flint-shift: null;
  -flint-internal-width: 17.1875%;
  -flint-internal-margin-right: 0.78125%;
  -flint-internal-margin-left: 0.78125%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
  .recursive {
    width: 22.91667%;
    margin-right: 1.04167%;
    margin-left: 1.04167%;
    -flint-instance-count: 2;
    -flint-parent-instance: none;
    -flint-key: laptop;
    -flint-breakpoint: 960px;
    -flint-columns: 12;
    -flint-span: 3;
    -flint-context: null;
    -flint-gutter: null;
    -flint-shift: null;
    -flint-internal-width: 22.91667%;
    -flint-internal-margin-right: 1.04167%;
    -flint-internal-margin-left: 1.04167%;
  }
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
  .recursive {
    width: 34.375%;
    margin-right: 1.5625%;
    margin-left: 1.5625%;
    -flint-instance-count: 3;
    -flint-parent-instance: none;
    -flint-key: tablet;
    -flint-breakpoint: 640px;
    -flint-columns: 8;
    -flint-span: 3;
    -flint-context: null;
    -flint-gutter: null;
    -flint-shift: null;
    -flint-internal-width: 34.375%;
    -flint-internal-margin-right: 1.5625%;
    -flint-internal-margin-left: 1.5625%;
  }
}
@media only screen and (min-width: 0) and (max-width: 320px) {
  .recursive {
    width: 68.75%;
    margin-right: 3.125%;
    margin-left: 3.125%;
    -flint-instance-count: 4;
    -flint-parent-instance: none;
    -flint-key: mobile;
    -flint-breakpoint: 320px;
    -flint-columns: 4;
    -flint-span: 3;
    -flint-context: null;
    -flint-gutter: null;
    -flint-shift: null;
    -flint-internal-width: 68.75%;
    -flint-internal-margin-right: 3.125%;
    -flint-internal-margin-left: 3.125%;
  }
}
```

As you can see, since `"desktop"` is the framework `"default"`, it uses the output for desktop as the base styles. You can set this to any breakpoint you like. **So if you like mobile-first, you can do that.**

Whatever your `"default"` is set to, flint will not wrap those styles in media-queries, so that they may be used in non-supported browsers.

### Recursive shorthand with identical context

Use this if your nested context is *identical* across all breakpoints. The `context` is the span of the elements parent. ***Update:*** You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a parent element with a Flint `instance` actually flint-exists or you'll get some weird output, or none at all. **Using `$context: auto` on fixed grids, the width with will be calculated by the parents width, instead of using the base breakpoints width.**

```scss
// `auto` will work
.parent {
	@include _(6);

	.recursive-child {
		@include _(3, auto); // Equivalent to : _(3, 6)
	}
}

// Will also work
.parent {
	@include _(6);
}
.parent .recursive-child {
	@include _(3, auto); // Equivalent to : _(3, 6)
}

// Will not work, as the child has no relation to the parent within the stylesheet
.parent {
	@include _(6);
}
.recursive-child {
	@include _(3, auto); // Equivalent to : _(3, 6)
}

// When using `auto`, Flint 'falls back' from the topmost selector until one is
// found that has an instance, and it will calculate it's context based on that
// instances span for the current breakpoint.
```

Outputs,
```scss
.recursive-child {
	display: block;
	float: left;
	width: 45.8333333333%;
	margin-right: 2.0833333333%;
	margin-left: 2.0833333333%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.recursive-child {
		width: 45.8333333333%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.recursive-child {
		width: 45.8333333333%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.recursive-child {
		width: 45.8333333333%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
```

### Recursive shorthand with variable context

Use this if your context is *not* indentical across breakpoints. The `context` is the span of the elements parent. You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a parent selector with a Flint instance actually flint-exists, or you'll throw a warning and get no output.

When using `$context: auto` on fixed grids, Flint will automagically calculate based on the width of the closest parent element instance.

*You must include an argument for each breakpoint in your config.*

```scss
.parent {
	@include _(10 8 6 4);

	.recursive-child {
		@include _(2, auto); // Equivalent to : _(2, 10 8 6 4)
	}
}
```

Outputs,
```scss
recursive-child {
	display: block;
	float: left;
	width: 17.5%;
	margin-right: 1.25%;
	margin-left: 1.25%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.recursive-child {
		width: 21.875%;
		margin-right: 1.5625%;
		margin-left: 1.5625%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.recursive-child {
		width: 29.1666666667%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.recursive-child {
		width: 43.75%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
```

### Variable shorthand

Use this if your content needs different spans across each breakpoints. The *order of operations* for this matches the order entered in your `config`.

To hide an element on a specific breakpoint, input `0` as its span.

*You must include an argument for each breakpoint in your config.*

```scss
.variable {
	@include _(8 6 0 4);
}
```

Outputs,
```scss
.variable {
	display: block;
	float: left;
	width: 48.4375%;
	margin-right: 0.78125%;
	margin-left: 0.78125%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.variable {
		width: 47.91667%;
		margin-right: 1.04167%;
		margin-left: 1.04167%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.variable {
		display: none;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.variable {
		width: 93.75%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
```

### Variable shorthand with context

Use this if you're *nesting* columns using the variable shorthand. The `context` is the span of the elements parent. Before using `$context: auto`, be sure a parent element with a Flint `instance` actually flint-exists or you'll get some weird output, or none at all.

```scss
.parent {
	@include _(16 12 8 4);

	.variable-child {
		@include _(14 10 6 2, 16 12 8 4); // Equivalent to : _(14 10 6 2, auto)
	}
}
```

Outputs,
```scss
.variable-child {
	display: block;
	float: left;
	width: 85.9375%;
	margin-right: 0.78125%;
	margin-left: 0.78125%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.variable-child {
		width: 81.25%;
		margin-right: 1.0416666667%;
		margin-left: 1.0416666667%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.variable-child {
		width: 71.875%;
		margin-right: 1.5625%;
		margin-left: 1.5625%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.variable-child {
		width: 43.75%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
```

### Wrapping in media queries

Use these if you need to apply breakpoint specific styling.

```scss
.wrap {
	@include _(desktop) {
		// Only desktop
	}
}
.wrap {
	@include _(greater than mobile) {
		// All sizes above mobile's breakpoint
	}
}
.wrap {
	@include _(10em greater than tablet) {
		// All sizes 10em above tablet's breakpoint
	}
}
.wrap {
    @include _(greater than 60em) {
        // All sizes above 60em
    }
}
.wrap {
	@include _(less than tablet) {
		// All sizes under tablet
	}
}
.wrap {
	@include _(1em less than laptop) {
		// All sizes 1em under laptop
	}
}
.wrap {
    @include _(less than 40em) {
        // All sizes under 40em
    }
}
.wrap {
	@include _(for desktop tablet) {
		// Only for desktop and tablet
	}
}
.wrap {
	@include _(from mobile to laptop) {
		// All sizes from mobile to laptop
	}
}
.wrap {
	@include _(from desktop to infinity) {
		// All sizes from desktop to infinity
	}
}
.wrap {
    @include _(from 20em to 40em) {
        // All sizes from 20em to 40em
    }
}
```

### Call by alias

Use if you want to define each span without shorthands.

```scss
.name {
	@include _(desktop, 8);
	@include _(laptop, 4);
	@include _(tablet, 8);
	@include _(mobile, 4);
}

// With context,
// .name {
//	  @include _(desktop, 4, 16, $gutter: alpha);
// }
```

Outputs,
```scss
.name {
    display: block;
    float: left;
    width: 48.4375%;
    margin-right: 0.78125%;
    margin-left: 0.78125%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
    .name {
        width: 31.25%;
        margin-right: 1.04167%;
        margin-left: 1.04167%;
    }
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
    .name {
        width: 96.875%;
        margin-right: 1.5625%;
        margin-left: 1.5625%;
    }
}
@media only screen and (min-width: 0) and (max-width: 320px) {
    .name {
        width: 93.75%;
        margin-right: 3.125%;
        margin-left: 3.125%;
    }
}
```

### Gutter modifiers

Here are different gutter modifiers that may be called in when defining spans using the `$gutter` variable. The `$gutter` variable allows you to pass in either a recursive argument, or a variable argument, similar to `$span`.

_**Note:** When defining `$gutter: center`, the float property will be set to `none` in order to center your column._

```scss
// Default margins
.gutter-default {
	// other aliases : `normal` | `regular`
	@include _(desktop, 4, $gutter: default);
}

// Center column
.gutter-center {
	@include _(desktop, 4, $gutter: center);
}

// No left margin
.gutter-alpha {
	// other aliases : `no-left` | `first`
	@include _(desktop, 4, $gutter: alpha);
}

// No right margin
.gutter-omega {
	// other aliases : `no-right` | `flint-last`
	@include _(desktop, 4, $gutter: omega);
}

// No margins
.gutter-row {
	// other alias : `none`
	@include _(desktop, 4, $gutter: row);
}

// Places gutters on inside by reducing column width by [gutter*2]
.gutter-inside {
	@include _(desktop, 4, $gutter: inside);
}

// Variable gutter
.variable-gutter {
	@include _(16 12 8 4, $gutter: row alpha center normal);
}

// Recursive gutter
.recursive-gutter {
	@include _(16 12 8 4, $gutter: row);
}
```
Outputs,
```scss
.gutter-normal {
	display: block;
	float: left;
	width: 23.4375%;
    margin-right: 0.78125%;
    margin-left: 0.78125%;
}
.gutter-center {
	display: block;
	float: none;
	width: 23.4375%;
    margin-right: auto;
    margin-left: auto;
}
.gutter-alpha {
	display: block;
	float: left;
	width: 24.21875%;
	margin-right: 0.78125%;
	margin-left: 0;
}
.gutter-omega {
	display: block;
	float: left;
	width: 24.21875%;
	margin-right: 0;
	margin-left: 0.78125%;
}
.gutter-row {
	display: block;
	float: left;
	width: 25%;
	margin-right: 0;
	margin-left: 0;
}
.gutter-inside {
	display: block;
	float: left;
	width: 21.875%;
	margin-right: 0.78125%;
	margin-left: 0.78125%;
}
.variable-gutter {
	display: block;
	float: left;
	width: 100%;
	margin-right: 0;
	margin-left: 0;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.variable-gutter {
		width: 98.95833%;
		margin-right: 1.04167%;
		margin-left: 0;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.variable-gutter {
		width: 98.4375%;
		margin-right: 0;
		margin-left: 1.5625%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.variable-gutter {
		width: 87.5%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
.recursive-gutter {
	display: block;
	float: left;
	width: 100%;
	margin-right: 0;
	margin-left: 0;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.recursive-gutter {
		width: 100%;
		margin-right: 0;
		margin-left: 0;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.recursive-gutter {
		width: 100%;
		margin-right: 0;
		margin-left: 0;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.recursive-gutter {
		width: 100%;
		margin-right: 0;
		margin-left: 0;
	}
}
```

## Syntax support

As of `1.6.0`, you can add syntax support for your preferred syntax. I built the system for BEM, but it should be easily extendable to
support your preferred syntax. Simply create a function which parses a string of selectors into a valid list. For example, the BEM syntax
function parses the selector string (for example, `.block__element__element`) like so,

```scss
/**
 * Parser to support BEM syntax
 *
 * @param {List} $selectors - string of selectors to parse
 *
 * @return {List} - parsed list of selectors according to syntax
 */
@function flint-support-syntax-bem($selectors) {
	// Clean up selector, remove double underscores for spaces
	//  add pseudo character to differentiate selectors
	$selectors: flint-replace-substring(inspect($selectors), "__", "/");
	// Parse string back to list without pseudo character
	$selectors: flint-string-to-list($selectors, "/");
	// Define top-most parent of selector
	$parent: nth($selectors, 1);
	// Create new list of parsed selectors
	$selector-list: ($parent);

	// Loop over each selector and build list of selectors
	@each $selector in $selectors {
		// Make sure current selector is not the parent
		@if $selector != $parent {
			// Save to selector list
			$selector-list: append($selector-list, ($parent + "__" + $selector), "comma");
			// Define new parent
			$parent: $parent + "__" + $selector;
		}
	}

	// Return the list of parsed selectors
	@return $selector-list;
}

```

This will be parsed into a list of selectors: `.block, .block__element, .block__element__element`. The list of selectors can then be used by
instance system to look up a selectors parent, etc. To support your own preferred syntax: create a `flint-support-syntax-<syntax-name>` function
and hook into it through the config `"support-syntax": "<syntax-name>"` option -- the system will attempt to use the `call()` function in
order to parse the selector string.

#### Officially supported syntaxes
* [BEM](http://bem.info/)

If you use one that isn't here, let me know and I'll look into officially supporting it.

## Support

You can tweet [@FlintGrid](https://twitter.com/FlintGrid) with any questions or issues and I'll look into it. Be sure to include a [Gist](https://gist.github.com) or a [SassMeister](http://sassmeister.com) link.

## Authors

[Ezekiel Gabrielse](http://ezekielg.com)

## Contributing

As an open-source project, contributions are more than welcome, they're extremely helpful and actively encouraged. If you see any room for improvement, open an [issue](https://github.com/ezekg/flint/issues) or submit a [pull request](https://github.com/ezekg/flint/pulls). Also, make sure to take a look at the [contributing doc](CONTRIBUTING.md).

## License

Flint is available under the [MIT](http://opensource.org/licenses/MIT) license.
