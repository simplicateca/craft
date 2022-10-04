// app.settings.js

// node modules
require('dotenv').config();
const path = require('path');

// settings
module.exports = {
    alias: {
        'vue$': 'vue/dist/vue.esm.js',
        '@': path.resolve('../src'),
    },
    entry: {
        'app': [
            '@/js/app.js',
            '@/css/app.pcss',
            '@/fonts/merriweather-latin-900.woff',
            '@/fonts/merriweather-latin-900.woff2',
            '@/fonts/lato-latin-300.woff',
            '@/fonts/lato-latin-300.woff2',
            '@/fonts/lato-latin-700.woff',
            '@/fonts/lato-latin-700.woff2',            
            '@/fonts/JetBrainsMono-Regular.woff',
            '@/fonts/JetBrainsMono-Regular.woff2',
            '@/fonts/JetBrainsMono-Bold.woff',
            '@/fonts/JetBrainsMono-Bold.woff2'
        ],
    },
    extensions: [ '.tsx', '.ts', '.js', '.vue' ],
    name: 'Website Project',
    paths: {
        dist: path.resolve('../cms/web/dist/'),
    },
    urls: {
        criticalCss: 'http://example.test/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
};