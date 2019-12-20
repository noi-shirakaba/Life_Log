module.exports = {
  configureWebpack: {
    devtool: 'source-map',
  },
  // options...
  devServer: {
    watchOptions: {
      ignored: /node_modules/,
      aggregateTimeout: 300,
      poll: 1000,
    },
    host: '0.0.0.0',
    port: '8080',
  }
}