###
grunt-screenshot-element
https://github.com/smallmultiples/grunt-screenshot-element

Copyright (c) 2013 Small Multiples
Licensed under the MIT license.
 ###

module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig(
        'screenshot-element':
            options:
                selector: '#main'
                viewport:
                    width: 1024
                    height: 768
            chart:
                options:
                    selector: '.chart'
                images: [
                    url: 'http://www.google.fr'
                    file: 'images/google.png'
                    selector: '#hplogo'
                ]

    )

    # Actually load this plugin's task(s).
    grunt.loadTasks('tasks')

    grunt.registerTask('default', ['screenshot-element:chart'])