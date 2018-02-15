const path = require('path')
const clean = require('clean-webpack-plugin')
const webpack = require('webpack')

const buildPath = '.tmp/assets/javascripts'

// split output JS into 'critical' (above-the-fold) scripts and the rest (which can be loaded on-demand)
module.exports = env => {
  return {
    entry: {
      critical: ['picturefill'],
      main: './source/assets/javascripts/main.js',
    },
    output: {
      path: path.resolve(__dirname, buildPath),
      filename: '[name].bundle.js',
    },
    module: {
      rules: [
        {
          test: /\.jsx?$/,
          enforce: 'pre',
          exclude: /node_modules/,
          use: {
            loader: 'eslint-loader',
            options: {
              formatter: require('eslint-friendly-formatter'),
              cache: env.development && true,
              failOnWarning: env.production && true
            }
          }
        },
        {
          test: /source\/assets\/javascripts\/.*\.js$/,
          exclude: /node_modules|\.tmp|vendor/,
          use: {
            loader: 'babel-loader',
            options: {
              presets: ['es2015'],
            }
          }
        },
      ],
    },
    plugins: [
      new clean([buildPath]),
      new webpack.optimize.UglifyJsPlugin({
        compress: {
          warnings: false
        }
      })
    ]
  }
}
