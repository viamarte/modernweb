ModernWeb [![Build Status](https://travis-ci.org/viamarte/modernweb.png)](https://travis-ci.org/viamarte/modernweb)
=========

![ModernWeb Banner](https://s3-sa-east-1.amazonaws.com/modernweb/screens/modernweb_screenshot.jpg)

A banner that encourages users to improve their web experience by updating their browsers to a HTML5/CSS3 capable.
The idea came when we were having problems with older versions of Internet Explorer, with so many sites out there
using great APIs that are not available for older browsers people can't expericence the real web of today. So we
decided to create ModernWeb, a banner that encourages people to switch to newer, better capable browsers.

To put it on your website put this script at the end of your body tag:

	<script type="text/javascript" src="https://s3-sa-east-1.amazonaws.com/modernweb/scripts/ModernWeb.min.js"></script>

[Check ModernWeb website for more information](http://viamarte.github.com/modernweb)

[Wanna download it? Click here](https://s3-sa-east-1.amazonaws.com/modernweb/scripts/ModernWeb.min.js)

Development
-----------

This project uses [Grunt](http://gruntjs.com) to speed and automate the build process, if you want to contribute follow the instructions:

1. Download Node.JS with NPM if you don't have it yet. Get it [here](http://nodejs.org/download).

2. Fork this repository and clone it in your machine.

3. Now you have to be sure you have grunt command line interface, open your terminal and run:

		sudo npm install -g grunt-cli

4. On you terminal, switch to the modernweb direcory on your cloned repository, then run:

   		npm install

   This will tell NPM to install the project dependencies as listed in that package.json file.

5. OK, you can now build the project for the first time with the command:

   		grunt build

   Or just

   		grunt

**Tip**: The project comes pre-built, so you won't see any changes unless you make some.

If none of this help you and you still want to contribute please open a GitHub Issue, we will be
happy to hear you.

Documenting ModernWeb
---------------------

ModernWeb is documented by Docco, it uses the comments in CoffeeScript code to generate the documentation.

Everytime you generate new code update the documentation with:

	grunt document

You can also document, test, lint and minify with just one command as explained earlier:

	grunt build

Author:
-------

A Via Marte project.

Curator: Matheus R. Kautzmann

Contributors:

Heinrich Goebl - German translation

Giorgio Polvara - Italian translation

Gregório Chalinski Kusowski - Improvements in the css

License
-------

This project is under MIT license, as you can see [here](./LICENSE.md).
