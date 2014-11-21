module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    qunit: {
      all: ['test/*.html'],
      quick: ['test/test_jquery_1_10.html']
    },
    browserDependencies: {
      "options": {},
      "underscore": {
        "dir": "test/lib/underscore",
        "files": [
          {
            "underscore-1.7.0.js": "http://underscorejs.org/underscore.js"
          }
        ],
      },
      "jquery": {
        "dir": "test/lib/jquery",
        "files": [
          {
            "jquery-1.4.4.js": "http://code.jquery.com/jquery-1.4.4.js"
          },
          {
            "jquery-1.10.2.js": "http://code.jquery.com/jquery-1.10.2.js"
          },
          {
            "jquery-2.0.3.js": "http://code.jquery.com/jquery-2.0.3.js"
          }
        ]
      },
      "qunit": {
        "dir": "test/lib/qunit",
        "files": [
          {
            "qunit-1.11.0.js": "https://raw.github.com/jquery/qunit/v1.11.0/qunit/qunit.js"
          },
          {
            "qunit-1.11.0.css": "https://raw.github.com/jquery/qunit/v1.11.0/qunit/qunit.css"
          }
        ]
      },
    },
    jshint: {
      all: ['Gruntfile.js', 'src/__file-name__.js', 'test/tests.js']
    }
  });
  grunt.loadNpmTasks('grunt-contrib-qunit');
  grunt.loadNpmTasks('grunt-browser-dependencies');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.registerTask('default', ['browserDependencies', 'jshint', 'qunit:all']);
  grunt.registerTask('check', ['jshint', 'qunit:quick']);
};
