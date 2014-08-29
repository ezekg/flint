## Contributing to Flint

We love contributors! If you would like to contribute to Flint, please adhere the following guidelines:

* **Please, do not issue a pull request without a related issue.** _All_ pull requests must reference an issue in the [issue queue](https://github.com/ezekg/flint/issues) and will only be looked at after discussion has taken place about the given issue. _Any pull request created that does not reference an issue will be closed._
* **All pull requests should be tested against our [standard test suite](#testing).** If any of the tests fail, we will ask you to fix your code so that the tests no longer fail. Any new features that are added must have accompanying passing tests before being considered. During a pull request, we may ask for additional tests to be written in order to ensure that what is being changed does not have negative effects elsewhere.
* **Create a new pull request for each individual feature added or bug fixed, unless they are related.** Contributions that _are not_ in the form of a pull request will not be considered. If we make changes or suggest that you make changes to your code, don't take it personally, as we are sticklers for a consistent coding standard throughout Flint. _If you submit a pull request that contains more than one feature or bug fix that are not related, we might ask you to rewrite your commits._
* **Before filing an issue** ensure that the issue is reproducible either by using [SassMeister](http://sassmeister.com/) or under Bundler control. Post the versions of all gems being used and the smallest set of example code of how to reproduce the error. _Issues that are not reproducible will be closed._

### Testing

We have automated tests set up to ensure our build is working. To test, you must install [Bundler](http://bundler.io/), which will allow you to install all needed gem versions. Once you have Bundler up and running, run `bundler install` to install all of Flint's dependencies. After that, you can run the test suite once with `rake test`, or you can also watch the directory while you work with `rake test[watch]`.
