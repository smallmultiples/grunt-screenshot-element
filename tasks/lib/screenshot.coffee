page = require('webpage').create()
system = require('system')

getDate = ->
    date = new Date()
    return date.getUTCFullYear() + '-' +
        ('00' + (date.getUTCMonth() + 1)).slice(-2) + '-' +
        ('00' + date.getUTCDate()).slice(-2) + ' ' +
        ('00' + date.getUTCHours()).slice(-2) + ':' +
        ('00' + date.getUTCMinutes()).slice(-2) + ':' +
        ('00' + date.getUTCSeconds()).slice(-2)

# The parameters for the help
params = [
    '-u,  --url              The page URL'
    '-s,  --selector         [The selector, body by defaut]'
    '-i,  --image            [The output image, screenshot-DATE.png by default]'
    '-vw, --viewport-width   [The viewport width, 1024 by default]'
    '-vh, --viewport-height  [The viewport height, 768 by default]'
    '-c,  --css              [CSS rules]'
    '-j,  --js               [JavaScript script]'
    '-t,  --timeout          [Timeout]'
    '-h,  --help             Show this message'
]

showHelp = ->
    console.log('Usage:')
    params.forEach((param) ->
        console.log('    ' + param)
    )
    phantom.exit()

options =
    url           : ''
    selector      : 'body'
    image         : 'screenshot-' + getDate() + '.png'
    viewportWidth : 1024
    viewportHeight: 768
    css           : ''
    js            : ''
    timeout       : 4
system.args.forEach((arg, i) ->
    switch arg
        when '-u', '--url'
            options.url = system.args[i + 1]
        when '-s', '--selector'
            options.selector = system.args[i + 1]
        when '-i', '--image'
            options.image = system.args[i + 1]
        when '-vw', '--viewport-width'
            options.viewportWidth = system.args[i + 1]
        when '-vh', '--viewport-height'
            options.viewportHeight = system.args[i + 1]
        when '-c', '--css'
            options.css = system.args[i + 1]
        when '-j', '--js'
            options.js = system.args[i + 1]
        when '-t', '--timeout'
            options.timeout = system.args[i + 1]
        when '-h', '--help'
            showHelp()
            return null
)
if system.args.length is 1
    showHelp()
else
    if options.url is ''
        console.error('No URL specified!')
        phantom.exit()
    page.viewportSize =
        width:  options.viewportWidth
        height: options.viewportHeight
    page.open(options.url, (status) ->
        if status isnt 'success'
            console.error('Unable to load the address "' + options.url + '"!')
            phantom.exit()
        else
            setTimeout(->
                # Page.clipRect is the clipRect of the selected element
                page.clipRect = page.evaluate((sel, css, js) ->
                    if css
                        style = document.createElement('style')
                        style.appendChild(document.createTextNode(css))
                        document.head.appendChild(style)

                    if js
                        eval(js)

                    clipRect = document.querySelector(sel).getBoundingClientRect()
                    return {
                        top: clipRect.top
                        left: clipRect.left
                        width: clipRect.width
                        height: clipRect.height
                    }
                , options.selector, options.css, options.js)

                page.render(options.image)
                phantom.exit()
            options.timeout)
    )