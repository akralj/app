var path = require('path')
var webpack = require('webpack')
var ExtractTextPlugin = require("extract-text-webpack-plugin")
//var MinifyPlugin = require("babel-minify-webpack-plugin")


// get serverPort from main server/config.coffee
try {
  require('coffeescript').register();
  serverConfig = require("../server/config")("development");
  serverPort = serverConfig.appPort
} catch (error) {
  // default serverPort if serverConfig is missing or no server part in project
  // access app at: http://localhost:7777
  serverPort = 7778
}


// rules used in dev and production
var baseRules =  [
  {
    test: /\.(png|jpg|gif|svg)$/,
    loader: 'file-loader',
    options: {
      objectAssign: 'Object.assign'
    }
  },
  {
    test: /\.styl$/,
    loader: ['style-loader', 'css-loader', 'stylus-loader']
  },
  {
    enforce: "pre",
    test: /\.coffee$/, // include .coffee files
    loader: "less-terrible-coffeelint-loader",
    exclude: /node_modules/
  },
  {
    test: /\.coffee$/,
    use: [ 'coffee-loader' ]
  }
]


module.exports = {
  entry: './src/index.coffee',
  output: {
    path: path.resolve(__dirname, './dist'),
    publicPath: '/dist/',
    filename: 'build.js'
  },
  resolve: {
    extensions: ['.coffee', '.js', '.vue', '.json'],
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      'static': path.resolve(__dirname, './static')
    }
  },

  module: {
    rules: baseRules.concat([
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {
            coffee: "coffee-loader!less-terrible-coffeelint-loader"
          }
        }
      }
    ])
  },
  devServer: {
    historyApiFallback: true,
    noInfo: true,
    disableHostCheck: true,
    host: "0.0.0.0",
    port: serverPort - 1 ,
    proxy: [
    {
      context: [ "/api", "/assets"],
      target: "http://0.0.0.0:" + serverPort
    }
  ]
  },
  performance: {
    hints: false
  },
  devtool: '#eval-source-map'
}

if (process.env.NODE_ENV === 'production') {

  module.exports.module.rules = baseRules.concat([
    {
      test: /\.vue$/,
      loader: 'vue-loader',
      options: {
        loaders: {
          css: ExtractTextPlugin.extract({
            use: 'css-loader',
            fallback: 'vue-style-loader' // <- this is a dep of vue-loader, so no need to explicitly install if using npm3
          })
        }
      }
    }
  ])

  module.exports.devtool = '#source-map'
  // http://vue-loader.vuejs.org/en/workflow/production.html
  module.exports.plugins = (module.exports.plugins || []).concat([
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    }),
    new ExtractTextPlugin("style.css"),
    //new MinifyPlugin() // when using coffeescript2 in the future
    new webpack.optimize.UglifyJsPlugin({ sourceMap: true, compress: { warnings: false } })
  ])
}
