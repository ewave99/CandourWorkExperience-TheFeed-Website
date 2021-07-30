const mix = require('laravel-mix');

mix.js('resources/js/site.js', 'public/js');
mix.sass('resources/sass/styles.scss', 'public/css');

mix.browserSync('localhost:8080');

if (mix.inProduction()) {
   mix.version();
}
