// webpack.prod.js - production builds
const LEGACY_CONFIG = 'legacy';
const MODERN_CONFIG = 'modern';

// node modules
const git = require('git-rev-sync');
const glob = require('glob-all');
const merge = require('webpack-merge');
const path = require('path');
const webpack = require('webpack');

// webpack plugins
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const CompressionPlugin = require('compression-webpack-plugin');
const CreateSymlinkPlugin = require('create-symlink-webpack-plugin');
const CriticalCssPlugin = require('critical-css-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const WebappWebpackPlugin = require('webapp-webpack-plugin');
const zopfli = require('@gfx/zopfli');

// config files
const common = require('./webpack.common.js');
const pkg = require('./package.json');
const settings = require('./webpack.settings.js');

// Configure file banner
const configureBanner = () => {
    const timestamp = new Date();
    try {
        return {
            banner: [
                '/*!',
                ' * @project        ' + settings.name,
                ' * @name           ' + '[filebase]',
                ' * @author         ' + pkg.author.name,
                ' * @build          ' + timestamp.toString(),
                ' * @release        ' + git.long() + ' [' + git.branch() + ']',
                ' * @copyright      Copyright (c) ' + timestamp.getFullYear() + ' ' + settings.copyright,
                ' *',
                ' */',
                ''
            ].join('\n'),
            raw: true
        };
    } catch {
        return {
            banner: [
                '/*!',
                ' * @project        ' + settings.name,
                ' * @name           ' + '[filebase]',
                ' * @author         ' + pkg.author.name,
                ' * @build          ' + timestamp.toString(),
                ' * @copyright      Copyright (c) ' + timestamp.getFullYear() + ' ' + settings.copyright,
                ' *',
                ' */',
                ''
            ].join('\n'),
            raw: true
        };
    }
};

// Configure Compression webpack plugin
const configureCompression = () => {
    return {
        filename: '[path].gz[query]',
        test: /\.(js|css|html|svg)$/,
        threshold: 10240,
        minRatio: 0.8,
        deleteOriginalAssets: false,
        compressionOptions: {
            numiterations: 15,
            level: 9
        },
        algorithm(input, compressionOptions, callback) {
            return zopfli.gzip(input, compressionOptions, callback);
        }
    };
};


// Configure Critical CSS
const configureCriticalCss = () => {
    return (settings.criticalCssConfig.pages.map((row) => {
            const criticalSrc = settings.urls.critical + row.url;
            const criticalDest = settings.criticalCssConfig.base + row.template + settings.criticalCssConfig.suffix;
            console.log("source: " + criticalSrc + " dest: " + criticalDest);
            return new CriticalCssPlugin({
                base: './',
                src: criticalSrc,
                target: criticalDest,
                extract: false,
                inline: false,
                minify: true,
                width: settings.criticalCssConfig.criticalWidth,
                height: settings.criticalCssConfig.criticalHeight,
            })
        })
    );
};

// Configure Clean webpack
const configureCleanWebpack = () => {
    return {
        cleanOnceBeforeBuildPatterns: settings.paths.dist.clean,
        verbose: true,
        dry: false
    };
};

// Configure Html webpack
const configureHtml = () => {
    return {
        templateContent: '',
        filename: 'webapp.html',
        inject: false,
    };
};

// Configure optimization
const configureOptimization = (buildType) => {
    if (buildType === LEGACY_CONFIG) {
        return {
            splitChunks: {
                cacheGroups: {
                    default: false,
                    common: false,
                    styles: {
                        name: settings.vars.cssName,
                        test: /\.(s[ac]ss|css|vue)$/,
                        chunks: 'all',
                        enforce: true
                    }
                }
            },
            minimizer: [
                new TerserPlugin(
                    configureTerser()
                ),
                new OptimizeCSSAssetsPlugin({
                    cssProcessorOptions: {
                        map: {
                            inline: false,
                            annotation: true,
                        },
                        safe: true,
                        discardComments: true
                    },
                })
            ]
        };
    }
    if (buildType === MODERN_CONFIG) {
        return {
            minimizer: [
                new TerserPlugin(
                    configureTerser()
                ),
            ]
        };
    }
};

// Configure Sass loader
const configureSassLoader = (buildType) => {
    if (buildType === LEGACY_CONFIG) {
        return {
            test: /\.s[ac]ss$/i,
            use: [
                MiniCssExtractPlugin.loader,
                {
                    loader: 'css-loader',
                    options: {
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
            ]
        };
    }

    // Don't generate CSS for the modern config in production
    if (buildType === MODERN_CONFIG) {
        return {
            test: /\.s[ac]ss$/i,
            loader: 'ignore-loader'
        };
    }
};

// Configure terser
const configureTerser = () => {
    return {
        cache: true,
        parallel: true,
        sourceMap: true
    };
};

// Configure Webapp webpack
const configureWebapp = () => {
    return {
        logo: settings.webappConfig.logo,
        prefix: settings.webappConfig.prefix,
        cache: false,
        inject: 'force',
        favicons: {
            appName: pkg.name,
            appDescription: pkg.description,
            developerName: pkg.author.name,
            developerURL: pkg.author.url,
            path: settings.paths.dist.base,
        }
    };
};

// Production module exports
module.exports = [
    merge(
        common.legacyConfig,
        {
            output: {
                filename: path.join('./js', '[name]-legacy.[chunkhash].js'),
            },
            mode: 'production',
            devtool: 'source-map',
            optimization: configureOptimization(LEGACY_CONFIG),
            module: {
                rules: [
                    configureSassLoader(LEGACY_CONFIG)
                ],
            },
            plugins: [
                new MiniCssExtractPlugin({
                    path: path.resolve(__dirname, settings.paths.dist.base),
                    filename: path.join('./css', '[name].[chunkhash].css'),
                }),
                new webpack.BannerPlugin(
                    configureBanner()
                ),
                new HtmlWebpackPlugin(
                    configureHtml()
                ),
                new WebappWebpackPlugin(
                    configureWebapp()
                ),
                new CompressionPlugin(
                    configureCompression()
                ),
                new CreateSymlinkPlugin(
                    settings.createSymlinkConfig,
                    true
                ),
            ].concat(
                configureCriticalCss()
            )
        }
    ),
    merge(
        common.modernConfig,
        {
            output: {
                filename: path.join('./js', '[name].[chunkhash].js'),
            },
            mode: 'production',
            devtool: 'source-map',
            optimization: configureOptimization(MODERN_CONFIG),
            module: {
                rules: [
                    configureSassLoader(MODERN_CONFIG),
                ],
            },
            plugins: [
                new CleanWebpackPlugin(
                    configureCleanWebpack()
                ),
                new webpack.BannerPlugin(
                    configureBanner()
                ),
                new CompressionPlugin(
                    configureCompression()
                ),
            ]
        }
    ),
];
