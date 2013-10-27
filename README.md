# grunt-screenshot-element

> Take a screenshot of a DOM element.

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-screenshot-element --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-screenshot-element');
```

## The "screenshot-element" task

### Overview
In your project's Gruntfile, add a section named `screenshot-element` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  screenshot-element: {
    options: {
      // Task-specific options go here.
    },
    your_target: {
      // Target-specific options and images list go here.
    },
  },
})
```

### Options
The options are by priority, from the less specific to the most precise, e.g: `options` < `your_target.options` < `your_target.files[n].options`

#### options.selector
Type: `String`
Default value: `'svg`

The selector of the element you want to screenshot (**NB: The element is selected with `document.querySelector` which mean that only the first one will be selected.**)

#### options.viewport
Type: `Object`
Default value: `{ width: 1024, height: 768 }`

An object with two keys, `width` and `height`, it will set the viewport of the page.

#### options.css
Type: `String`
Default value: none

Add CSS to the page before taking a screenshot.

#### options.js
Type: `String`
Default value: none

Add JavaScript to the page before taking a screenshot.

#### options.url
Type: `String`
Default value: none

The URL of the page you want to screenshot.

#### options.file
Type: `String`
Default value: ``

The output of the screenshot.

#### options.timeout
Type: `Number`
Default value: `4`

The number of milliseconds when after which the screenshot will be taken.


### Images
`images` are set for each targets, they are an array of objects, you can re-specify `options` for each image.

### Usage Examples

#### Default Options
This example will create a screenshot of the `#hplogo` on `http://www.google.fr` and will save it to `images/google.png`. The viewport of the browser will be of 1024 by 768.

```js
grunt.initConfig({
    'screenshot-element': {
        options: {
            selector: '#main'
          , viewport: {
                width: 1024
              , height: 768
            }
        }
      , chart: {
            options: {
                selector: '.chart'
              , css: 'body { background: red; }'
              , js: '$("#button").click()'
            }
          , images: [
                {
                    url: 'http://www.google.fr'
                  , file: 'images/google.png'
                  , selector: '#hplogo'
                }
            ]
        }
    }
})
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style.

## Release History
* 2013-10-28   v0.1.4   Added `js` option to add JavaScript to the page 
* 2013-08-19   v0.1.3   Fixes `selector` option
* 2013-08-19   v0.1.2   Added `timeout` option
* 2013-08-19   v0.1.1   Fixes package.json
* 2013-07-26   v0.1.0   First release