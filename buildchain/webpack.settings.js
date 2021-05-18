// webpack.settings.js - webpack settings config

// node modules
require('dotenv').config();

// Webpack settings exports
// noinspection WebpackConfigHighlighting
module.exports = {
    name: "Example Project",
    copyright: "Example Company, Inc.",
    paths: {
        src: {
            base: "../src/",
            css: "../src/css/",
            js: "../src/js/"
        },
        dist: {
            base: "../cms/web/dist/",
            clean: [
                '**/*',
            ]
        },
        templates: "../cms/templates/"
    },
    urls: {
        live: "",
        local: "",
        critical: "",
        publicPath: () => process.env.PUBLIC_PATH || "/dist/",
    },
    vars: {
        cssName: "styles"
    },
    entries: {
        "app": "app.js",
    },
    babelLoaderConfig: {
        exclude: [
            /(node_modules|bower_components)/
        ],
    },
    criticalCssConfig: {
        base: "../cms/web/dist/criticalcss/",
        suffix: "_critical.min.css",
        criticalHeight: 1200,
        criticalWidth: 1200,
        pages: [
            {
                url: "",
                template: "pages/home"
            }
        ]
    },
    devServerConfig: {
        public: () => process.env.DEVSERVER_PUBLIC || "http://localhost:8080",
        host: () => process.env.DEVSERVER_HOST || "localhost",
        poll: () => process.env.DEVSERVER_POLL || false,
        port: () => process.env.DEVSERVER_PORT || 8080,
        https: () => process.env.DEVSERVER_HTTPS || false,
    },
    manifestConfig: {
        basePath: ""
    },
    createSymlinkConfig: [
        {
            origin: "img/favicons/favicon.ico",
            symlink: "../favicon.ico"
        }
    ],
    webappConfig: {
        logo: "../src/img/favicon-src.png",
        prefix: "img/favicons/"
    }
};
