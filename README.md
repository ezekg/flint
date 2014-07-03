# Flint [![Gem Version](https://badge.fury.io/rb/flint-gs.svg)](http://badge.fury.io/rb/flint-gs)

**Flint is designed to be a flexible layout toolkit that developers can use for any responsive grid-based project.** Built on Sass 3.3, Flint is capable of complex responsive layouts customized at each breakpoint; all while using a single mixin, having minimal output, as well as being completely semantic. All of your layout settings are housed in a simple config file that is immensely customizable. Flint will only output the code you need, and nothing else. We handle the  hard stuff, so you can focus on the rest.

Take it for a spin on [SassMeister.com](http://sassmeister.com/gist/11489231)!

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
	* [Shift modifiers](#shift)
1. [Syntax support](#syntax-support)
1. [Authors](#authors)
1. [License](#license)

## Requirements

* Sass ~> 3.3.0
* Compass ~> 1.0.0.alpha.19

## Installation

1. Install via Ruby `gem install flint-gs`, or Bower `bower install flint`
2. Add `require "flint"` to your `config.rb`
3. Import it in your stylesheets with `@import "flint"`

If you don't want to install it, then simply download or clone the current build files. Use the starter `config.rb` to require any custom functions Flint uses; currently this is required, as we're making use of custom SassScript functions until the 'script `&`' [returns to Sass](https://gist.github.com/nex3/8050187). Adjust the paths according to your project.

## Documentation

### Config

Flint's `config` map is unique in the ability that you may define an unlimited number of breakpoints for your project. Whether that be 2 breakpoints, or even 12 breakpoints. Flint gives you full control over the column count on each breakpoint, and unlike most frameworks, you may name these anything that you like. Flint is smart and will figure out which one you're talking about.

Speaking of not being like most frameworks, Flint does not require you to set a ridiculous amount of variables just to use a single breakpoint. It actually doesn't require you to set *any* variables. It also doesn't require you to install a seperate extension so that you can define your breakpoints; *all of these features are baked into Flint.* Your columns are fully related to your breakpoints, so that there is never any confusion and everything is kept nice and simple.

##### Usage

To begin, you can either use the default `config` (below) which comes baked in, or you can define your own using the `$flint` variable, using the default config as a template. Settings may be entered in `px` or `em`, and Flint will do the rest.

*Keep in mind, whatever unit you choose to use here needs to be used consistently throughout Flint. No mixing of `px` and `em` units. Also, Flint does require that you follow a `DESC` order for your breakpoint configuration, this way it can traverse the config map correctly to output valid media queries.*

```scss
// Configuration map
// -------------------------------------------------------------------------------
// @param breakpoint [map] : Here you can set up your various breakpoints for your
// project. Any number of breakpoints is acceptable. You must include a column
// count and breakpoint value for each listed breakpoint. The order does have
// to follow a `DESC` order. Unit (px | em) chosen here must be used consistently
// throughout the rest of the config map.
// -------------------------------------------------------------------------------
// @param default [string] : alias of breakpoint that is your grid default
// @param grid [string] : style of grid
// @param gutter [number | false] : contextual size of gutter
// @param float-style [number | false] : float direction
// @param max-width [number | bool] : max-width for containers
// @param center-container [bool] : if you want a centered container
// @param border-box-sizing [bool] : if you want box-sizing: border-box applied
// @param support-syntax [string | false] : syntax to support
// @param debug-mode [bool] : ouputs debug properties
// -------------------------------------------------------------------------------

$flint: (

	// Grid configuration
	"config": (

		// Define breakpoints [any amount of breakpoints]
		// Any alias you like, minus reserved Flint words [i.e. "settings", "config", etc.]
		"desktop": (

			// Options: 0-infinity
			"columns": 16,

			// Options: number[unit]
			"breakpoint": 80em,
		),

		// Same applies for other breakpoints
		// ----
		// Remember, you're not fixed to just 4 breakpoints like we have here
		"laptop": (
			"columns": 12,
			"breakpoint": 60em,
		),
		"tablet": (
			"columns": 8,
			"breakpoint": 40em,
		),
		"mobile": (
			"columns": 4,
			"breakpoint": 20em,
		),

		// Additional grid settings [required]
		"settings": (

			// Any breakpoint's alias
			"default": "mobile",

			// Options: fluid | fixed
			"grid": "fluid",

			// Options: number[unit]
			"gutter": 0.625em,

			// Options: left | right
			"float-style": "left",

			// Options: true [uses highest breakpoint] | false | number[unit]
			"max-width": true,

			// Options: true | false
			"center-container": true,

			// Options: true | false
			"border-box-sizing": true,

			// Syntax support: string | false
			"support-syntax": false,

			// Options: true | false
			"debug-mode": false,
		),
	),
) !default;
```

### Foundation

If you selected `"border-box-sizing": true`, then it is *advised* to create a global foundation instance like so,

```scss
@include _(foundation);
```

That way your output won't be riddled with `box-sizing` declarations everytime you define a span. This will automatically output the rules onto the global selector `*`. In the future this might be automatic, but for now I'll keep it manual.

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

### Clear

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
  -flint-output-width: 17.1875%;
  -flint-output-margin-right: 0.78125%;
  -flint-output-margin-left: 0.78125%;
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
    -flint-output-width: 22.91667%;
    -flint-output-margin-right: 1.04167%;
    -flint-output-margin-left: 1.04167%;
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
    -flint-output-width: 34.375%;
    -flint-output-margin-right: 1.5625%;
    -flint-output-margin-left: 1.5625%;
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
    -flint-output-width: 68.75%;
    -flint-output-margin-right: 3.125%;
    -flint-output-margin-left: 3.125%;
  }
}
```

As you can see, since `"desktop"` is the framework `"default"`, it uses the output for desktop as the base styles. You can set this to any breakpoint you like. **So if you like mobile-first, you can do that.**

Whatever your `"default"` is set to, **flint** will not wrap those styles in media-queries, so that they may be used in non-supported browsers.

### Recursive shorthand with identical context

Use this if your nested context is *identical* across all breakpoints. The `context` is the span of the elements parent. ***Update:*** You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a parent element with a Flint `instance` actually exists or you'll get some weird output, or none at all. **Using `$context: auto` on fixed grids, the width with will be calculated by the parents width, instead of using the base breakpoints width.**

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

Use this if your context is *not* indentical across breakpoints. The `context` is the span of the elements parent. You can now use `$context: auto`, and we'll do all the calculations for you. Just be sure a parent selector with a Flint instance actually exists, or you'll throw a warning and get no output.

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

Use this if you're *nesting* columns using the variable shorthand. The `context` is the span of the elements parent. Before using `$context: auto`, be sure a parent element with a Flint `instance` actually exists or you'll get some weird output, or none at all.

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
		// only desktop
	}
}
.wrap {
	@include _(greater than mobile) {
		// all sizes above mobile's breakpoint
	}
}
.wrap {
	@include _(10em greater than tablet) {
		// all sizes 10em above tablet's breakpoint
	}
}
.wrap {
    @include _(greater than 60em) {
        // all sizes above 60em
    }
}
.wrap {
	@include _(less than tablet) {
		// all sizes under tablet
	}
}
.wrap {
	@include _(1em less than laptop) {
		// all sizes 1em under laptop
	}
}
.wrap {
    @include _(less than 40em) {
        // all sizes under 40em
    }
}
.wrap {
	@include _(for desktop tablet) {
		// only for desktop and tablet
	}
}
.wrap {
	@include _(from mobile to laptop) {
		// all sizes from mobile to laptop
	}
}
.wrap {
	@include _(from desktop to infinity) {
		// all sizes from desktop to infinity
	}
}
.wrap {
    @include _(from 20em to 40em) {
        // all sizes from 20em to 40em
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

// with context,
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

```scss
// default margins
.gutter-default {
	// other aliases : `normal` | `regular`
	@include _(desktop, 4, $gutter: default);
}

// no left margin
.gutter-alpha {
	// other aliases : `no-left` | `first`
	@include _(desktop, 4, $gutter: alpha);
}

// no right margin
.gutter-omega {
	// other aliases : `no-right` | `last`
	@include _(desktop, 4, $gutter: omega);
}

// no margins
.gutter-row {
	// other alias : `none`
	@include _(desktop, 4, $gutter: row);
}

// places gutters on inside by reducing column width by [gutter*2]
.gutter-inside {
	@include _(desktop, 4, $gutter: inside);
}

// variable gutter
.variable-gutter {
	@include _(16 12 8 4, $gutter: row alpha omega normal);
}

// recursive gutter
.recursive-gutter {
	@include _(16 12 8 4, $gutter: row);
}
```
Outputs,
```scss
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

### Shift

Much like the gutter modifiers, you may also call in a shift parameter using the `$shift` variable. This will cause the element to shift the desired amount of columns using positive/negative left margins.

```scss
// shift 4 columns to the right across all breakpoints
.name {
	@include _(12 12 8 4, $shift: 4);
}

// shift 2 columns to the left across specified breakpoints
.name {
	@include _(12 12 8 4, $shift: -2 -2 0 0);
}
```

**One more** cool thing about flint is that you are not bound to the grid you define. Feel free to use decimals and math based on the breakpoint's column count in your arguments for extra fine tuned control over your layouts. Examples include, `decimals: (1.25), (3.333)`, `math: (3 - 2), (2 + 9), (16 / 3)`.

```scss
.break-the-grid {
	@include _(16/3 12.1 8.9 (5 - 1), $shift: 1.2 0 2 0, $gutter: row);
}
```
Outputs,
```scss
.break-the-grid {
	display: block;
	float: left;
	width: 33.33333%;
	margin-right: 0;
	margin-left: 7.5%;
	-flint-instance-count: 9;
	-flint-parent-instance: none;
	-flint-key: desktop;
	-flint-breakpoint: 1280px;
	-flint-columns: 16;
	-flint-span: 5.33333;
	-flint-context: null;
	-flint-gutter: row;
	-flint-shift: 1.2;
	-flint--output-width: 33.33333%;
	-flint--output-margin-right: 0;
	-flint--output-margin-left: 7.5%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.break-the-grid {
		width: 100.83333%;
		margin-right: 0;
		margin-left: 0%;
		-flint-instance-count: 10;
		-flint-parent-instance: none;
		-flint-key: laptop;
		-flint-breakpoint: 960px;
		-flint-columns: 12;
		-flint-span: 12.1;
		-flint-context: null;
		-flint-gutter: row;
		-flint-shift: 0;
		-flint--output-width: 100.83333%;
		-flint--output-margin-right: 0;
		-flint--output-margin-left: 0%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.break-the-grid {
		width: 111.25%;
		margin-right: 0;
		margin-left: 25%;
		-flint-instance-count: 11;
		-flint-parent-instance: none;
		-flint-key: tablet;
		-flint-breakpoint: 640px;
		-flint-columns: 8;
		-flint-span: 8.9;
		-flint-context: null;
		-flint-gutter: row;
		-flint-shift: 2;
		-flint--output-width: 111.25%;
		-flint--output-margin-right: 0;
		-flint--output-margin-left: 25%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.break-the-grid {
		width: 100%;
		margin-right: 0;
		margin-left: 0%;
		-flint-instance-count: 12;
		-flint-parent-instance: none;
		-flint-key: mobile;
		-flint-breakpoint: 320px;
		-flint-columns: 4;
		-flint-span: 4;
		-flint-context: null;
		-flint-gutter: row;
		-flint-shift: 0;
		-flint--output-width: 100%;
		-flint--output-margin-right: 0;
		-flint--output-margin-left: 0%;
	}
}
```

## Syntax support

As of `1.6.0`, you can add syntax support for your preferred syntax. I built the system for BEM, but it should be easily extendable to
support your preferred syntax. Simply create a function which parses a string of selectors into a valid list. For example, the BEM syntax
function parses the selector string (for example, `.block__element__element`) like so,

```scss
// Support BEM syntax
// -------------------------------------------------------------------------------
// @param $selectors [string] : string of selectors to parse
// -------------------------------------------------------------------------------
// @return [string] : parsed list of selectors according to syntax

@function support-syntax-bem($selectors) {
	$selectors: string-to-list($selectors, "_");
	$parent: nth($selectors, 1);
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

	// Return the list of transformed selectors
	@return $selector-list;
}
```

This will be parsed into a list of selectors: `.block, .block__element, .block__element__element`. The list of selectors can then be used by
instance system to look up a selectors parent, etc. To support your own preferred syntax: create a `support-syntax-<syntax-name>` function
and hook into it through the config `"support-syntax": "<syntax-name>"` option -- the system will attempt to use the `call()` function in
order to parse the selector string.

#### Officially supported syntaxes
* [BEM](http://bem.info/)

If you make one that isn't here, let me know and I'll look into officially supporting it.

## Authors

[Ezekiel Gabrielse](http://ezekielg.com)

## License

Flint is available under the [MIT](http://opensource.org/licenses/MIT) license.
