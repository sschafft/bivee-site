var sass = require('node-sass');,
    importOnce = require('node-sass-import-once');

sass.render({
    file: "source/assets/stylesheets/main",
    importer: importOnce,
    importOnce: {
        index: false,
        css: false,
        bower: false
    }
});
