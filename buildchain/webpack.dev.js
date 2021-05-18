// webpack.dev.js - developmental builds
const LEGACY_CONFIG = 'legacy';
const MODERN_CONFIG = 'modern';

// node modules
const merge = require('webpack-merge');
const path = require('path');
const webpack = require('webpack');

// config files
const common = require('./webpack.common.js');
const pkg = require('./package.json');
const settings = require('./webpack.settings.js');

// Configure the webpack-dev-server
const configureDevServer = (buildType) => {
    return {
        public: settings.devServerConfig.public(),
        contentBase: path.resolve(__dirname, settings.paths.templates),
        host: settings.devServerConfig.host(),
        port: settings.devServerConfig.port(),
        https: !!parseInt(settings.devServerConfig.https()),
        disableHostCheck: true,
        hot: true,
        overlay: true,
        watchContentBase: true,
        watchOptions: {
            poll: !!parseInt(settings.devServerConfig.poll()),
            ignored: /node_modules/,
        },
        headers: {
            'Access-Control-Allow-Origin': '*'
        },
    };
};

// Configure the Sasscss loader
const configureSassLoader = () => {
    return {
        test: /\.s[ac]ss$/i,
        use: [
            {
                loader: 'style-loader',
            },
            {
                loader: 'vue-style-loader',
            },
            {
                loader: 'css-loader',
                options: {
                    url: false,
                    importLoaders: 2,
                    sourceMap: true
                }
            },
            {
                loader: 'resolve-url-loader'
            },
            {
                loader: 'sass-loader',
                options: {
                    sourceMap: true
                }
            },
            {
                loader: 'sass-resources-loader',
                options: {
                    resources: [path.resolve(__dirname, settings.paths.src.css, 'settings/global.scss' )]
                },
            },
        ],
    };
};

// Development module exports
module.exports = [
    merge(
        common.legacyConfig,
        {
            output: {
                filename: path.join('./js', '[name]-legacy.[hash].js'),
                publicPath: settings.devServerConfig.public() + '/',
            },
            mode: 'development',
            devtool: 'inline-source-map',
            devServer: configureDevServer(LEGACY_CONFIG),
            module: {
                rules: [
                    configureSassLoader(LEGACY_CONFIG),
                ],
            },
            plugins: [
                new webpack.HotModuleReplacementPlugin(),
            ],
        }
    ),
    merge(
        common.modernConfig,
        {
            output: {
                filename: path.join('./js', '[name].[hash].js'),
                publicPath: settings.devServerConfig.public() + '/',
            },
            mode: 'development',
            devtool: 'inline-source-map',
            devServer: configureDevServer(MODERN_CONFIG),
            module: {
                rules: [
                    configureSassLoader(MODERN_CONFIG),
                ],
            },
            plugins: [
                new webpack.HotModuleReplacementPlugin(),
            ],
        }
    ),
];
