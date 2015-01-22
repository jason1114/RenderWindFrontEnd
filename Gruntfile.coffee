module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json')
    
    browserify: {
      dist: {
        files: {
          'build/scripts/browserified_script.js': [
            'app/*.coffee',
            'app/**/**.coffee',
            'app/**/**/**.coffee'
          ] 
        },
        options: {
          transform: ['coffeeify']
        }
      }
    }

    concat: {
      options: {
        separator: ';',
      },
      bower_scripts: {
        src: [
          'assets/html5-boilerplate/js/vendor/modernizr-2.6.2.min.js',
          'assets/jquery/dist/jquery.js'
          'assets/foundation/js/foundation.js'
          'assets/dat-gui/build/dat.gui.min.js'
          'assets/flat-surface-shader/deploy/fss.min.js'
          'assets/angular/angular.js',
          'assets/angular-route/angular-route.js'
        ]
        dest: 'build/scripts/bower_scripts.js'
      }
      all: {
        src: [
          'build/scripts/bower_scripts.js', 
          'app/fss-setup.js'
          'build/scripts/browserified_script.js'],
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
            'assets/foundation/css/normalize.css'
            'assets/foundation/css/foundation.css'
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
      watchCoffee: {
        files: [
          'app/*.coffee',
          'app/**/**.coffee',
          'app/**/**/**.coffee'
        ] ,
        tasks: ['browserify', 'concat']
      },
      watchJs: {
        files: '<%concat.bower_scripts.src.concat("app/fss-setup.js")%>'
        tasks: ['concat']
      },
      # watchCss: {
      #   files: "<%
      #     files = []
      #     for dest, srcFiles of cssmin.combine.files
      #       files.concat srcFiles
      #   %>"
      #   tasks: ['cssmin']
        
      # }
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

