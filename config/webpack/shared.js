const environment = require('./environment');
const eslint = require('./loaders/eslint');
const path = require('path');

environment.loaders.append('eslint', eslint);
const webpackConfig = environment.toWebpackConfig();

webpackConfig.resolve.modules.push('@frontend');
webpackConfig.resolve.alias = {
  '@frontend': path.resolve(__dirname, '../../app/javascript/frontend'),
  '@': path.resolve(__dirname, '../../app/javascript')
};

module.exports = webpackConfig;
