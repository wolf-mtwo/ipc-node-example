'use strict'

module.exports = (grunt) ->

  PATTERN_LOAD_TASK =
    pattern: 'grunt-*'
    scope: 'devDependencies'
  (require 'load-grunt-tasks')(grunt, PATTERN_LOAD_TASK)

  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.initConfig
    coffee:
      server:
        files:[
          expand: true
          cwd: 'src/'
          src: ['**/*.coffee']
          dest: 'build/src/'
          ext: '.js'
        ]
    clean:
      build:
        options:
          force: true
        src: ['build']
    nodemon:
      server:
        script: 'build/src/app.js'
        options:
          ignore: ['public/**', 'node_modules/**']
          watch: ['Gruntfile.coffee', 'build']
          ext: 'js,html'
          cwd: __dirname
    watch:
      server:
        files: ['src/**/*.coffee']
        tasks: ['newer:coffee']
    concurrent:
      server:
        tasks: ['nodemon:server', 'watch']
        options:
          logConcurrentOutput: true

  grunt.registerTask 'build', [
    'clean'
    'coffee'
  ]

  grunt.registerTask 'dev', 'development mode',
    (target) ->
      grunt.task.run [
        'clean'
        'coffee'
        'concurrent'
      ]
