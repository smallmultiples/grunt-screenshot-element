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

params = [
    'index.coffee'
    'URL'
    '[selector, svg by default]'
    '[image, screenshot-date.png by default]'
    '[viewport width, 1024 by default]'
    '[viewport height, 768 by default]'
]
help = [
    '-h'
    '--h'
    'help'
]
# If ask for help or doesn't have the right number or arguments
if system.args.length < 2 or system.args.length > params.length + 1 or help.indexOf(system.args[1]) isnt -1
    console.log('Usage: ' + params.join(' '))
    phantom.exit(1)
else
    address        = system.args[1]
    sel            = system.args[2] or 'svg'
    viewportWidth  = system.args[4] or 1024
    viewportHeight = system.args[5] or 768
    css            = system.args[6]

    # Handle null value and 'null' value
    if not system.args[3] or system.args[3] is 'null'
        output = 'screenshot-' + getDate() + '.png'
    else
        output = system.args[3]

    page.viewportSize =
        width:  viewportWidth
        height: viewportHeight
    page.open(address, (status) ->
        if status isnt 'success'
            console.error('Unable to load the address "' + address + '"!')
            phantom.exit()
        else
            # Page.clipRect is the clipRect of the selected element
            page.clipRect = page.evaluate((sel, css) ->
                if css
                    style = document.createElement('style')
                    style.appendChild(document.createTextNode(css))
                    document.head.appendChild(style)

                clipRect = document.querySelector(sel).getBoundingClientRect()
                return {
                    top: clipRect.top
                    left: clipRect.left
                    width: clipRect.width
                    height: clipRect.height
                }
            , sel, css)

            page.render(output)
            phantom.exit()
    )