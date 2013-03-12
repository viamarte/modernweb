Testing ModernWeb
=================

The process of testing ModernWeb is done via mocha over phantomjs. This way we can automate tests in a grunt task and run they on a cli enviroment.

To run the tests just follow the instructions to set up your development enviroment, you alerady did that? Great, then just run (from the root folder):

	grunt test

This will run all the tests availabe in the ModernWebSpec.coffee file.

You can also run the tests in your browser by opening the TestRunner.html file.

Contributors:

Always run the tests before sending pull requests, it will help assure that your code didn't broke anything already working.

We will apreciate if you add tests for your pull requests when suitable, although this is not required it helps us to merge your request faster.

New tests to existing features are also welcome.