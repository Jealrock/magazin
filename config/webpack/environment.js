const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');

const vue = require('./loaders/vue');
const css = require('./loaders/css');
const eslint = require('./loaders/eslint');

environment.plugins.append('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.append('vue', vue);
environment.loaders.append('css', css);
environment.loaders.append('eslint', eslint);

module.exports = environment;
