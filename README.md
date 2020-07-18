## About simplicate-web/craft

This is an alternate scaffolding package for Craft 3 CMS projects to Pixel & Tonic's canonical [craftcms/craft](https://github.com/craftcms/craft) package.

It's based on the [nystudio107/craft](https://github.com/nystudio107/craft) package by Andrew Welch, but trimmed down and augmented to represent my preferred tool chain.
 
The project is based on [Craft CMS](https://CraftCMS.com) using a unique `templates/_boilerplate` system for web/AJAX pages, and implements a number of technologies/techniques:
 
* [Docker](https://www.docker.com/) Docker is used for local development; see **Setting Up Local Dev** below for details
* A base Twig templating setup as described in [An Effective Twig Base Templating Setup](https://nystudio107.com/blog/an-effective-twig-base-templating-setup)
* [webpack](https://webpack.js.org/) is used for the build system as per [An Annotated webpack 4 Config for Frontend Web Development](https://nystudio107.com/blog/an-annotated-webpack-4-config-for-frontend-web-development)
* [VueJS](https://vuejs.org/) is used for some of the interactive bits on the website as per 
* JSON-LD structured data as per [Annotated JSON-LD Structured Data Examples](https://nystudio107.com/blog/annotated-json-ld-structured-data-examples)
* Critical CSS as per [Implementing Critical CSS on your website](https://nystudio107.com/blog/implementing-critical-css)
* Frontend error handling as per [Handling Errors Gracefully in Craft CMS](https://nystudio107.com/blog/handling-errors-gracefully-in-craft-cms)
* A custom site module as per [Enhancing a Craft CMS 3 Website with a Custom Module](https://nystudio107.com/blog/enhancing-a-craft-cms-3-website-with-a-custom-module)
* CLI-based queue as per [Robust queue job handling in Craft CMS](https://nystudio107.com/blog/robust-queue-job-handling-in-craft-cms)
* FastCGI Static Cache as per [Static Page Caching with Craft CMS](https://nystudio107.com/blog/static-caching-with-craft-cms)
* [Craft-Scripts](https://github.com/nystudio107/craft-scripts) as described in the [Database & Asset Syncing Between Environments in Craft CMS](https://nystudio107.com/blog/database-asset-syncing-between-environments-in-craft-cms), [Mitigating Disaster via Website Backups](https://nystudio107.com/blog/mitigating-disaster-via-website-backups) & [Hardening Craft CMS Permissions](https://nystudio107.com/blog/hardening-craft-cms-permissions) articles

...and probably a bunch of other stuff too.

The following Craft CMS plugins are used on this site:

* [FastCGI Cache Bust](https://nystudio107.com/plugins/fastcgi-cache-bust) - to bust the FastCGI cache whenever entries are modified
* [Minify](https://nystudio107.com/plugins/minify) - to minify the HTML and inline JS/CSS
* [SEOmatic](https://nystudio107.com/plugins/seomatic) - for handling site-side SEO
* [Twigpack](https://nystudio107.com/plugins/twigpack) - for loading webpack-generated `manifest.json` resources in a modern way
* [Typogrify](https://nystudio107.com/plugins/typogrify) - for smart quotes and other typographic ligatures

You can read more about it in the [Setting up a New Craft 3 CMS Project](https://nystudio107.com/blog/setting-up-a-craft-cms-3-project) article.

## Using simplicate-web/craft

This project package works exactly the way Pixel & Tonic's [craftcms/craft](https://github.com/craftcms/craft) package works; you create a new project by first creating & installing the project:

    composer create-project simplicate-web/craft PATH

Make sure that `PATH` is the path to your project, including the name you want for the project, e.g.:

    composer create-project simplicate-web/craft craft3

## Setting Up Local Dev

You'll need Docker desktop for your platform installed to run the project in local development

* Set up a `.env` file in the `cms/` directory, based off of the provided `example.env`
* Set up a `.env.sh.` file in the `scripts/` directory, based off of the provided `example.env.sh`
* Start up the site with `docker-compose up` (the first build will be somewhat lengthy)
* On the first time setting it up, the `craft_php_1` container will fail; this is normal
* While docker is still running, open a second console shell and import the `seed_db.sql` database dump the first time from the `scripts/` dir with `./docker_restore_db.sh seed_db.sql`
* After the seed database is imported, use `^C` (Control-C) to stop the Docker containers, and restart them with `docker-compose up` and `craft_php_1` should then work properly, since the db has been seeded
* Navigate to `http://localhost:8000` to use the site; the `webpack-dev-server` runs off of `http://localhost:8080`

The CP login credentials are initially set as follows:

Login: `steve@simplicate.ca` \
Password: `letmein`

Obviously change these to whatever you like as needed

**N.B.:** Without authorization & credentials (which are private), the `./docker_pull_db.sh` will not work. It's provided here for instructional purposes

To update to the latest Composer packages (as constrained by the `cms/composer.json` semvers), do:
```
rm cms/composer.lock
docker-compose up
```

To update to the latest npm packages (as constrained by the `docker-config/webpack-dev-craft/package.json` semvers), do:
```
rm docker-config/webpack-dev-craft/package-lock.json
docker-compose up
```