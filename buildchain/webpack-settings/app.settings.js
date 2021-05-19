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
    copyright: 'Example Company',
    entry: {
        'app': [
            '@/js/app.js',
            '@/css/app.pcss',
            // '@/fonts/fontello.eot',
            // '@/fonts/fontello.ttf',
            // '@/fonts/fontello.woff',
            // '@/fonts/fontello.woff2',
            // '@/fonts/OperatorMonoSSm-Book.eot',
            // '@/fonts/OperatorMonoSSm-Book.ttf',
            // '@/fonts/OperatorMonoSSm-Book.woff',
            // '@/fonts/OperatorMonoSSm-Book.woff2',
            // '@/fonts/OperatorMonoSSm-BookItalic.eot',
            // '@/fonts/OperatorMonoSSm-BookItalic.ttf',
            // '@/fonts/OperatorMonoSSm-BookItalic.woff',
            // '@/fonts/OperatorMonoSSm-BookItalic.woff2',
        ],
        'emergency-message': '@/js/modules/emergency-message.js',
        'mobile-menu': '@/js/modules/mobile-menu.js',
    },
    extensions: [ '.tsx', '.ts', '.js', '.vue' ],
    name: 'Example Project',
    paths: {
        dist: path.resolve('../cms/web/dist/'),
    },
    urls: {
        criticalCss: 'http://example.test/',
        publicPath: () => process.env.PUBLIC_PATH || '/dist/',
    },
};