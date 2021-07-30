# Candour Statamic 3 Starter Kit

In the week beginning 26/07/2021 I did work experience at Candour Agency Ltd, Norwich (<https://withcandour.co.uk>).
I was given a website design for one of their clients, The Feed, and I implemented it as a working webpage from
one of their Statamic starter kits. Unfortunately at the moment it is only a static page so doesn't actually use
the installed Statamic CMS, however it was an excellent way to get to know how Statamic works alongside.

***Pre-existing README from the starter repository:***

## Docker
We have Docker Compose and Docker Sync set up for this project. The simplest way to get started would be through Docker Compose. The command to get the project running is:
```
docker-compose up
```
Once that command has been run docker will build an image for the website as well as starting the container for redis. Redis is used in this project to cache the filesystem from S3.

If you'd like to use Docker sync (this tends to improve performance when developing on MacOS devices) then you'll need to [install the package locally](http://docker-sync.io/) and then run:
```
docker-sync-stack start
```

If you're using Docker Sync you'll need to replace 'starter-kit' with a slugified version of the site you're working on in the volume names in both `docker-compose.sync.yml` and `docker-sync.yml`.

## Laravel mix
Laravel mix will be used for the frontend build system here, the commands are in `package.json` to get started on this, I'd recommend using the watch command during development as it will give you browser sync which reloads your browser once changes to the CSS/JS files have been made.

For CSS we're writing in SCSS, the code for this will be in `resources/sass` and will be automatically get compiled to CSS with autoprefixing and minification applied.

### Mix commands
- `npm run build` Builds the assets and generates the files
- `npm run watch` Builds the files and will refresh upon changes being made, this will allow you to view the site on http://localhost:3000 to view live updates

## Images
I'd recommend using our [imgix package](https://github.com/withcandour/statamic-imgix) for this project - it will enable you to crop/resize images within the antlers templates for the website as well as serving optimized versions of the images. Documentation can be found on the github page but feel free to DM Andrew with any questions.

## Users
The starter kit comes with a user with the email `devs@withcandour.co.uk` and a password of `test` - this will need changing before deployment.
