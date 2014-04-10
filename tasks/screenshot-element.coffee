###
grunt-screenshot-element
https://github.com/smallmultiples/grunt-screenshot-element

Copyright (c) 2013 Small Multiples
Licensed under the MIT license.
###

extend = require('lodash.assign')
clone = require('lodash.clone')
async = require('async')
os = require('os')

module.exports = (grunt) ->
    phantomjs = require('phantomjs')
    path = require('path')

    grunt.registerMultiTask('screenshot-element', 'Take a screenshot of a DOM element.', ->
        # Merge task-specific and/or target-specific options with these defaults.
        options = @options(
            selector: 'svg'
            viewport:
                width: 1024
                height: 768
            file: 'null'
            limit: os.cpus().length
        )

        # run asynchronously
        async.eachLimit(@data.images or [{}], options.limit, (image, next) ->
            run(extend(clone(options), image), next)
        @async())

    )

    run = (image, done) ->
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
        # use grunt for better output
        grunt.util.spawn(cmd: phantomjs.path, args: childArgs, done)
