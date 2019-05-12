module.exports = {
  test: /\.js|\.vue$/,
  exclude: /node_modules/,
  loader: 'eslint-loader',
  options: {
    emitError: false,
    emitWarning: true,
  },
};
