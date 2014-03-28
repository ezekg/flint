Flint
=====

**Flint is a seemingly simple Sass based grid-system** built on
**Sass 3.3** capable of complex responsive layouts customized at each 
breakpoint, all while using a single mixin. All of your layout
settings are housed in a simple config file. Flint will only
output the code you need, and nothing else. Flint handles the 
hard stuff, you do the rest. 

Here's a small [demo on Sassmeister (v0.0.3.alpha)](http://sassmeister.com/gist/9657552)
to show what Flint is capable of. This is only the alpha, so let
me know if you find any bugs, if you think the code could be
more efficient, or if you would just like to help out.

Enjoy.

-----

Config
------

Flint's `config map` is unique in the ability that you may
define an unlimited number of breakpoints for your project. 
Whether that be 2 breakpoints, or even 12. You're in full 
control of your columns as well. Also, unlike most frameworks, 
you may name these anything that you like. Flint is smart and 
will figure out which one you're talking about.

Settings may be entered in `px` or `em`, and flint
will do the rest.

*Keep in mind, whatever unit you choose to use here needs to 
be used consistently throughout. No mixing `px` and `em` units.*

```scss
$flint: (

	// grid configuration

	"config": (

		// define breakpoints

		"desktop": ( // [anything you like, aside from reserved Sass/Flint words]
			"columns": 16, // [0-infinity]
			"breakpoint": 1280px, // [0-infinity]
		),
		"laptop": (
			"columns": 12,
			"breakpoint": 960px,
		),
		"tablet": (
			"columns": 8,
			"breakpoint": 640px,
		),
		"mobile": (
			"columns": 4,
			"breakpoint": 320px,
		),

		// additional grid settings

		"settings": (
			"default": "mobile", // [any breakpoint's name, is default]
			"grid": "fluid", // [fluid, fixed]
			"gutter": 10px, // [0-infinity]
			"float-style": "left", // [left, right]
			"max-width": false, // [true (uses highest breakpoint), false, or any value]
			"center-container": true, // [true, false]
			"border-box-sizing": true, // [true, false]
		),
	),
);
```

Foundation
----------

If you selected `border-box-sizing: true`, then it is 
*advised* to create a global foundation instance like so,

```scss
@include flint(foundation);
```

That way your output won't be riddled with `box-sizing`
declarations everytime you define a span. This will automatically
output the rules onto the global selector `*`.

Container
---------

You may define containers, which simply act as a row without the `float`
property. This is really only useful on fixed grid layouts, or if you have a max-width set, but can be
used elsewhere as a simple wrapper if desired.

```scss
.container {
	@include flint(container);
}
```

Outputs,
```scss
.container {
	display: block;
	float: none;
	width: 100%;
}
```

Recursive shorthand
-------------------

Use this if you want *identical* column spans across all breakpoints.

```scss
.recursive {
	@include flint(3);
}
```

Outputs,
```scss
recursive {
	display: block;
	float: left;
	width: 17.1875%;
	margin-right: 0.78125%;
	margin-left: 0.78125%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.recursive {
		width: 22.9166666667%;
		margin-right: 1.0416666667%;
		margin-left: 1.0416666667%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.recursive {
		width: 34.375%;
		margin-right: 1.5625%;
		margin-left: 1.5625%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.recursive {
		width: 68.75%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
```

As you can see, since `desktop` is the framework `default`, it uses
the output for desktop as the base styles. You can set this to any
breakpoint you like. **So if you like mobile-first, you can do that.**

Whatever your `default` is set to, **flint** will not wrap those
styles in media-queries, so that they may be used in non-supported browsers.

Recursive shorthand with identical context
------------------------------------------

Use this if your nested context is *identical* across all breakpoints. The `context` is the span of the elements parent. **Pro tip: `$context` can also be used to break out of the usual column count for a specific breakpoint. For example, if one of your breakpoints column count is `16`, you could set use `$context: 24`, and it will calculate its width as if that breakpoint had a column count of `24`.**

```scss
//  .parent {
//  	   @include flint(6);
//  }

.recursive {
	@include flint(3, 6);
}
```

Outputs,
```scss
.recursive {
	display: block;
	float: left;
	width: 45.8333333333%;
	margin-right: 2.0833333333%;
	margin-left: 2.0833333333%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.recursive {
		width: 45.8333333333%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.recursive {
		width: 45.8333333333%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.recursive {
		width: 45.8333333333%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
```

Recursive shorthand with variable context
-----------------------------------------

Use this if your context is *not* indentical across breakpoints. The `context` is the span of the elements parent.

*You must include an argument for each breakpoint in your config.*

```scss
//  .parent {
//	   @include flint(10 8 6 4);
//  }

.recursive {
	@include flint(2, 10 8 6 4);
}
```

Outputs,
```scss
recursive {
	display: block;
	float: left;
	width: 17.5%;
	margin-right: 1.25%;
	margin-left: 1.25%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.recursive {
		width: 21.875%;
		margin-right: 1.5625%;
		margin-left: 1.5625%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.recursive {
		width: 29.1666666667%;
		margin-right: 2.0833333333%;
		margin-left: 2.0833333333%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.recursive {
		width: 43.75%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
```

Variable shorthand
------------------

Use this if your content needs different spans across each breakpoints.
The *order of operations* for this matches the order entered in your `config`.

*You must include an argument for each breakpoint in your config.*

```scss
.variable {
	@include flint(8 6 4 4);
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
		width: 46.875%;
		margin-right: 1.5625%;
		margin-left: 1.5625%;
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

Variable shorthand with context
-------------------------------

Use this if you're *nesting* columns using the variable shorthand. The `context` is the span of the elements parent.

```scss
//  .parent {
//	   @include flint(16 12 8 4);
//  }

.variable {
	@include flint(14 10 6 2, 16 12 8 4);
}
```

Outputs,
```scss
.variable {
	display: block;
	float: left;
	width: 85.9375%;
	margin-right: 0.78125%;
	margin-left: 0.78125%;
}
@media only screen and (min-width: 641px) and (max-width: 960px) {
	.variable {
		width: 81.25%;
		margin-right: 1.0416666667%;
		margin-left: 1.0416666667%;
	}
}
@media only screen and (min-width: 321px) and (max-width: 640px) {
	.variable {
		width: 71.875%;
		margin-right: 1.5625%;
		margin-left: 1.5625%;
	}
}
@media only screen and (min-width: 0) and (max-width: 320px) {
	.variable {
		width: 43.75%;
		margin-right: 3.125%;
		margin-left: 3.125%;
	}
}
```

Wrapping in media queries
-------------------------

Use these if you need to apply breakpoint specific styling.

```scss
.wrap {
	@include flint(desktop) {
		// only desktop
	}
}
.wrap {
	@include flint(greater than mobile) {
		// all sizes above mobile's breakpoint
	}
}
.wrap {
	@include flint(10em greater than tablet) {
		// all sizes 10em above tablet's breakpoint
	}
}
.wrap {
	@include flint(less than tablet) {
		// all sizes under tablet
	}
}
.wrap {
	@include flint(1em less than laptop) {
		// all sizes 1em under laptop
	}
}
.wrap {
	@include flint(for desktop tablet) {
		// only for desktop and tablet
	}
}
.wrap {
	@include flint(from mobile to laptop) {
		// all sizes from mobile to laptop
	}
}
.wrap {
	@include flint(from desktop to infinity) {
		// all sizes from desktop to infinity
	}
}
```

Call by name
------------

Use if you want to define each span without shorthands.

```scss
.name {
	@include flint(desktop, 4);
}

// with context,
// .name {
//	  @include flint(desktop, 4, 16);
// }
```

Outputs,
```scss
.name {
	display: block;
	float: left;
	width: 23.4375%;
	margin-right: 0.78125%;
	margin-left: 0.78125%;
}
```

Gutter modifiers
----------------

Here are different gutter modifiers that may be called in when
defining spans using the `$gutter` variable. **You should note**, 
that when using shorthands the gutter modifiers are recursive
across all breakpoints.

```scss
// no left margin
.name {
	@include flint(desktop, 4, $gutter: alpha);
}

// no right margin
.name {
	@include flint(desktop, 4, $gutter: omega);
}

// no margins
.name {
	@include flint(desktop, 4, $gutter: row);
}
```

Shift
-----

Much like the gutter modifiers, you may also call in a shift
parameter using the `$shift` variable. This will cause the element 
to shift the desired amount of columns using positive/negative 
left margins. 

*Currently, `$gutter` modifiers and `$shift` modifiers cannot be used*
*in conjuction with eachother. This functionality will be added soon*

```scss
// shift 4 columns to the right across all breakpoints
.name {
	@include flint(12 12 8 4, $shift: 4);
}

// shift 2 columns to the left across specified breakpoints
.name {
	@include flint(12 12 8 4, $shift: -2 -2 0 0);
}
```

One more cool thing about flint is that you are not bound to
the grid you define. Feel free to use decimals in your arguments
for extra fine tuned control over your layouts.

```scss
.break-the-grid {
	@include flint(16 12.1 8.9 4, $shift: 1.2 0 2 0, $gutter: row);
}
```

----

**More features coming soon.**

*Let me know if you find any bugs, or think of a feature that would be useful.*

***Fork the project if you believe that the code could be more effecient and***
***would like to help out.***






