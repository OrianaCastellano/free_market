'use strict';

var gulp = require('gulp');
var scss = require("gulp-sass");
var uglify = require('gulp-uglify');
var autoprefixer = require('gulp-autoprefixer');
var sourcemaps = require('gulp-sourcemaps');
var browserSync = require('browser-sync');

// Esta tarea corre el servidor local

// Transpilando el SCSS a CSS en la carpeta principal
gulp.task('scss', () => {
  return gulp.src('src/scss/**/*.scss')
    .pipe(scss())
    .pipe(gulp.dest('dist/public/css/'))
    .pipe(browserSync.stream());
})

// Minificar codigo JS en la carpeta principal
gulp.task('uglify', function () {
  gulp.src('src/js/**/*.js')
    .pipe(uglify())
    .pipe(gulp.dest('dist/static/js'));
});

// La carpeta principal es /dist
gulp.task('default', () => {
  // Refrescar la página a medida que guardo algún archivo
  gulp.watch("src/scss/**/*.scss", gulp.series('scss'));

})