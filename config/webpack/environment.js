const { environment } = require('@rails/webpacker')
const { ProvidePlugin } = require('webpack')

const webpack = require('webpack')
environment.plugins.append('Provide', 
  new ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
