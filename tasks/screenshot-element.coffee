###
grunt-screenshot-element
https://github.com/smallmultiples/grunt-screenshot-element

Copyright (c) 2013 Small Multiples
Licensed under the MIT license.
###

module.exports = (grunt) ->
    childProcess = require('child_process')
    phantomjs = require('phantomjs')
    path = require('path')

    phantomBin = phantomjs.path
    _ = grunt.util._

    grunt.registerMultiTask('screenshot-element', 'Take a screenshot of a DOM element.', ->
        # Merge task-specific and/or target-specific options with these defaults.
        options = @options(
            selector: 'svg'
            viewport:
                width: 1024
                height: 768
            file: 'null'
        )

        for image in @data.images
            # Add the opions to the image
            image = _.extend(_.clone(options), image)

            # The arguments for the phantomjs task
            childArgs = [
                path.join(__dirname, 'lib/screenshot.coffee')
                '-u' + image.url
                '-s' + image.selector
                '-i' + image.file
                '-vw' + image.viewport.height
                '-vh' + image.viewport.width
                '-c' + image.css
                '-t' + image.timeout
            ]

            # Launch the phantomjs task
            childProcess.execFile(phantomBin, childArgs)
    )