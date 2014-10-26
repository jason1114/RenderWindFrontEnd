module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json')
    
    browserify: {
      dist: {
        files: {
            'build/scripts/browserified_script.js': ['app/*.coffee','app/**/**.coffee','app/**/**/**.coffee'] 
          },
          options: {
            transform: ['coffeeify']
          }
      }
    }

    # coffee: {

    # }

    concat: {
      options: {
        separator: ';',
      },
      bower_scripts: {
        src: [
          'assets/html5-boilerplate/js/vendor/modernizr-2.6.2.min.js',
          'assets/angular/angular.js',
          'assets/angular-route/angular-route.js'
        ]
        dest: 'build/scripts/bower_scripts.js'
      }
      all: {
        src: ['build/scripts/bower_scripts.js', 'build/scripts/browserified_script.js'],
        dest: 'build/scripts/all.js'
      }
    }

    
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'build/scripts/all.js',
        dest: 'build/scripts/all.min.js'
      }
    }

    stylus: {
      compile: {
        options: {},
        files: {
          'build/styles/app.css': 'app/app.styl',       # 'destination': 'source'
        }
      }
    }
    cssmin: {
      combine: {
        files: {
          'build/styles/bower_styles.css': [
            'assets/html5-boilerplate/css/normalize.css',
            'assets/html5-boilerplate/css/main.css',
          ]
          'build/styles/app_styles.css': ['build/styles/app.css']
        }
      }
      all: {
        files: {
          'build/styles/all.min.css': [
            'build/styles/bower_styles.css', 
            'build/styles/app_styles.css'
          ]
        }
      }
    }

    watch: {

    }
  })

  # Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  # Default task(s).
  grunt.registerTask('default', ['browserify', 'concat', 'stylus', 'cssmin'])
  grunt.registerTask('release', ['default', 'uglify'])

