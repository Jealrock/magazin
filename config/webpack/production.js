process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const sharedWebpackConfig = require('./shared');

module.exports = sharedWebpackConfig;
