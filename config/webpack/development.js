process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment');
const path = require('path');

const eslint = require('./loaders/eslint');
environment.loaders.append('eslint', eslint);

const webpackConfig = environment.toWebpackConfig();

webpackConfig.resolve.modules.push('@frontend');
webpackConfig.resolve.alias = {
  '@frontend': path.resolve(__dirname, '../../app/javascript/frontend'),
  '@': path.resolve(__dirname, '../../app/javascript')
};

module.exports = webpackConfig;

