process.env.NODE_ENV = process.env.NODE_ENV || 'test';

const environment = require('./environment')

const eslint = require('./loaders/eslint');
environment.loaders.append('eslint', eslint);

module.exports = environment.toWebpackConfig()

