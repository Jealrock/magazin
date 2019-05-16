const environment = require('./environment');

const path = require('path');

const webpackConfig = environment.toWebpackConfig();

webpackConfig.resolve.modules.push('@frontend');
webpackConfig.resolve.alias = {
  '@frontend': path.resolve(__dirname, '../../app/javascript/frontend'),
  '@': path.resolve(__dirname, '../../app/javascript')
};

module.exports = webpackConfig;


