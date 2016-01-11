'use strict'

var sass = require('node-sass'),
    importOnce = require('node-sass-import-once');

sass.render({
    file: "source/assets/stylesheets/main.scss",
    importer: importOnce,
    importOnce: {
        index: false,
        css: true,
        bower: false
    },
    includePaths: [
        "source/assets/stylesheets/",
        "node_modules"
    ]
});
