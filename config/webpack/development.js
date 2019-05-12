process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const sharedWebpackConfig = require('./shared');

module.exports = sharedWebpackConfig;
