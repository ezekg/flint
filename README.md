[![Flint - Grid System](http://flint.gs/wp-content/themes/flint/images/logo.png)](http://flint.gs)

[![Gem](https://img.shields.io/gem/v/flint-gs.svg?style=flat-square)](https://rubygems.org/gems/flint-gs)
[![Bower](https://img.shields.io/bower/v/flint.svg?style=flat-square)](http://bower.io/search/?q=flint)
[![Travis](https://img.shields.io/travis/ezekg/flint.svg?style=flat-square)](https://travis-ci.org/ezekg/flint)
[![GitHub license](https://img.shields.io/github/license/ezekg/flint.svg?style=flat-square)](https://github.com/ezekg/flint/blob/master/LICENSE)

## What is Flint?
Flint is a responsive grid framework written in Sass, created to allow developers to rapidly produce responsive layouts that are built on a sophisticated foundation.

## What sets Flint apart?
Most notably? The syntax. Being a designer myself, a large amount of time was spent on this aspect. Flint is very unique in the fact that it uses only a single mixin for all output: `_(...)`.

Yes, it really is just an underscore. Easy to remember, huh? It shoves the function mumbo-jumbo out of the way and allows you to focus on the aspect that matters most: the actual layout. It also allows you to type your intentions in human terms.

```scss
@include _(from tablet to desktop) { ... }
```

In addition to that, as you can tell from the snippet above, Flint also handles your breakpoints for you. Long gone are the days that you need to download a separate plugin just so that you're able to create a truly responsive layout.

Flint allows you create an unlimited number of breakpoints, all of which have their own alias, column count and breakpoint. Want to name your 10 breakpoints after James Bond villians? By all means, go ahead.

One more cool thing? Flint is the only self-aware Sass grid system on the planet.* What does that mean? It means that every instance of Flint is logged into an 'instance map', so child elements can know their parent element's width; meaning we can have perfectly consistent gutters, no matter how odd your layout may be. Think of it as a self-correcting grid.

[Check out this short introduction over at Sitepoint.com](http://www.sitepoint.com/rapid-responsive-development-sass-flint/), and take it for a spin on [SassMeister.com](http://sassmeister.com/gist/228449011362bcdfe38c)!

Enjoy.

## Requirements

* Sass ~> `3.4.0`

## Installation

1. Install via Ruby `gem install flint-gs`, or Bower `bower install flint --save-dev`
2. If you're using Compass, add `require "flint"` to your `config.rb`
3. Import it into your stylesheet with `@import "flint"`

If you're not using Compass, you can require Flint and compile via cli:
```
scss --require ./lib/flint.rb example.scss > example.css
```

## Documentation

Documentation is located [here](http://flint.gs/docs).

_Tip: For simple projects, disable `instance-maps`, as it is has a large overhead and will increase your compile times._

## Syntax support

As of `1.6.0`, you can add syntax support for your preferred syntax. I built the system for BEM, but it should be easily extendable to
support your preferred syntax. Simply create a function which parses a string of selectors into a valid list. For example, the BEM syntax
function parses the selector string (for example, `.block__element__element`) like so,

```scss
///
/// Parser to support BEM syntax
///
/// @access private
///
/// @param {List} $selectors - string of selectors to parse
///
/// @return {List} - parsed list of selectors according to syntax
///
/// @group Internal Functions
///
@function flint-support-syntax-bem($selectors) { ... }
```
[View Source](https://github.com/ezekg/flint/blob/master/stylesheets/flint/functions/lib/_support-syntax-bem.scss)

This will be parsed into a list of selectors: `.block, .block__element, .block__element__element`. The list of selectors can then be used by the
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

_\* According to Wikipedia, not really. But, all jokes aside, it's pretty awesome._
