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
            chart:
                images: [
                    selector: 'body'
                    url: 'http://sasha-project.s3.amazonaws.com/afr-prod/projects/budget1314/build.html?type=pm&dimensions=wide'
                ]

    )

    # Actually load this plugin's task(s).
    grunt.loadTasks('tasks')

    grunt.registerTask('default', ['screenshot-element:chart'])