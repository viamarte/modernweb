#Gruntfile to build the whole thing
module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    #Lint Coffee scripts for ModernWeb Core distribution
    coffeelint:
      app: ['ModernWeb.coffee']
      tests:
        files:
          src:['Gruntfile.coffee', 'tests/ModernWebSpec.coffee']

    #Compile CoffeeScript
    coffee:
      options:
        bare: true
      compile:
        files:
          'ModernWeb.js': 'ModernWeb.coffee'
          'tests/ModernWebSpec.js' : 'tests/ModernWebSpec.coffee'

    #Minify JS script for ModernWeb Core distribution
    min:
      dist:
        src: ['ModernWeb.js']
        dest: 'dist/ModernWeb.min.js'

    #Execute tests with Mocha over PhantomJS
    mocha:
      options:
        run: true
      index: ['tests/TestRunner.html']

    #Generate documentation
    docco:
      debug:
        src: ['ModernWeb.coffee']
        options:
          output: 'docs/'

    #Clean folders and build files (goes back to default state, without build)
    clean: ['docs', 'dist', 'ModernWeb.js', 'tests/ModernWebSpec.js']

  #We use YUI Compressor instead of Uglify JS because of some bug
  #with exponential numbers in IE

  grunt.loadNpmTasks 'grunt-yui-compressor'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha'
  grunt.loadNpmTasks 'grunt-docco'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', ['coffeelint','coffee','mocha','min','docco']
  grunt.registerTask 'build', ['default']
  grunt.registerTask 'lint', ['coffeelint']
  grunt.registerTask 'test', ['lint','coffee','mocha']
  grunt.registerTask 'document', ['docco']

  #Task Travis CI execute to validate

  grunt.registerTask 'travis', ['test']