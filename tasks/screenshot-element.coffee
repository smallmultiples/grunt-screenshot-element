###
grunt-screenshot-element
https://github.com/smallmultiples/grunt-screenshot-element

Copyright (c) 2013 Small Multiples
Licensed under the MIT license.
###

extend = require('lodash.assign')
clone = require('lodash.clone')

module.exports = (grunt) ->
    childProcess = require('child_process')
    phantomjs = require('phantomjs')
    path = require('path')

    phantomBin = phantomjs.path

    grunt.registerMultiTask('screenshot-element', 'Take a screenshot of a DOM element.', ->
        # Merge task-specific and/or target-specific options with these defaults.
        options = @options(
            selector: 'svg'
            viewport:
                width: 1024
                height: 768
            file: 'null'
        )

        if @data.images
            for image in @data.images
                run(extend(clone(options), image))
        else
            run(options)
    )

    run = (image) ->
        # The arguments for the phantomjs task
        childArgs = [
            path.join(__dirname, 'lib/screenshot.coffee')
            '-u',  image.url
            '-s',  image.selector
            '-i',  image.file
            '-vh', image.viewport.height
            '-vw', image.viewport.width
            '-c',  image.css
            '-j',  image.js
            '-t',  image.timeout
            '-p',  JSON.stringify(image.paperSize)
            '-S',  JSON.stringify(image.settings)
        ]

        # Launch the phantomjs task
        childProcess.execFile(phantomBin, childArgs)
