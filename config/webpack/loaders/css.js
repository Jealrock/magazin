module.exports = {
  test: /\.css$/,
  use: [
    'vue-style-loader',
    'css-loader',
    {
      loader: 'postcss-loader',
      options: {
        plugins: [
          require('postcss-import'),
          require('postcss-custom-media')({ extensions: {
            '--phone-viewport': '(max-width: 30em)', // 480
            '--phoneLarge-viewport': '(max-width: 36em)', // 576
            '--tablet-viewport': '(max-width: 48em)', // 768
            '--desktopSmall-viewport': '(max-width: 53em)', // 848
            '--desktop-viewport': '(max-width: 60em)', // 960
            '--desktopLarge-viewport': '(max-width: 77em)' // 1232
            }}),
          require('postcss-nested'),
          require('postcss-cssnext')
        ]
      }
    }
  ]
};
