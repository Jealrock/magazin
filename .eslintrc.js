module.exports = {
  root: true,
  env: {
    node: true
  },
  'extends': [
    'plugin:vue/recommended',
    'airbnb-base'
  ],
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'import/no-extraneous-dependencies': 'off'
  },
  settings: {
    "import/resolver": {
      webpack: {
        config: "config/webpack/shared.js"
      }
    }
  }
}
