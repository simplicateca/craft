# simplicate-web/craft Change Log

## 1.4.2 - 2022.06.

### Changed

* No longer ignore the cms/.env.example file



## 1.4.1 - 2022.05.21

### Changed

* Forced zlib `1.2.12-r1` in webpack docker config, which was otherwise failing to build under some circumstances


## 1.4 - 2022.05.19

### Added

* Ability to assign parallax functionality to html elements using class/data attributes. See the `handleParallax` function in `src/js/app.js` 
* New base TwigExtension added to default SiteModule. Provides new twig filters for extracting or removing the leading HTML header tags (h1,h2,h3, etc) from a twig variable.
* Added default slug-based class names to the <body> tag for each page
* New default navigation menus - `primary` and `legal`

### Changed

* Consolidated the `emergency-message`, `content-container`, `mobile-menu` modules into `app.js`
* Re-arranged the base template so that all the site content is inside the `app.js` Vue container
* Updated the nomenclature for block twig file naming. See `cms/templates/_blocks/_loop.twig` for a reference
* Improved on the structure of previewing & including content fragments inside the page builder
* Replaced the `Navigate` plugin with the Verbb `Navigation` plugin
* Separated the mobile menu toggle button from the main mobile menu component
* Some general base template clean-up
* Tweaked the way emergency messages pop-up and push content down
* Matrixmate config now references `entries` and `repeater` blocks by their proper names & fields

### Removed

* No more html5shiv + respond.js support for IE8. No one should still be using that browser. 
* A/B option removed from the fragment block. Might return in the future as a `layout` option.
* `cms/templates/index.twig` was no longer needed since using `__home__` slug trick within page structure


## 1.3.6 - 2022.05.16

### Changed

* Updated to Craft 3.7.42
* Created default user groups for "Content Editor / Site Owner / SEO Editor"


## 1.3.5 - 2022.05.16

### Changed

* Fixed the errors that were plauging the package since swapping out mariadb for mysql server 8
* Added a Makefile command `make fixdb` to update mysql root user permissions if experiencing issues exporting the Craft CMS database

## 1.3.4 - 2022.02.27

### Changed

* Switched out mariadb docker for mysql to fix an issue with loading a seed DB on first run


## 1.3.3 - 2022.02.26

### Changed

* Updated Makefile
* Added database init on first docker-compose
* Reverted webpack back to node:14-alpine
* Force lowercase in container folder name in scripts/.env


## 1.3.2 - 2022.02.26

### Changed

* Updated README with improved instructions for installation
* Changed all content blocks from having a `headline` field to having an `eyebrow` field
* Fixed the Redactor "email" plugin so that it appears within the "Link" menu
* Changed the default Redactor menu to include inline styles
* Renamed the `Features` text block to `Repeater` to better describe it's content
* Updated the webpack docker container to `node:bullseye` to fix a build error installing `mozjpeg`
* Updated the `scripts/.env` file to try and guess the docker container name by reading the project folder

### Added

* Created the ability for admin users to toggle a field to make `Content Block Meta` details visible when viewing frontend pages.
* Created a new `Headline` block type
* Created a full page of redactor typography and content embed examples on the guide site
* Created default image transform
* Added a default configuration for the `Knock-Knock` plugin to protect the staging site


### Removed

* Removed file, fullscreen, and video buttons from the default Redactor config



## 1.3.1 - 2022.02.23

### Changed
* Completely overhauled content block design & implementation including 30+ sample matrix block layouts
* Enabled Tailwind project wide and began using it to replace CSS in .pcsss files where possible
* Upgraded base CMS to Pro version

### Added
* Created Hero & Sidebar block options
* Created a default sub-site (guide.domain.com) as a template for providing onsite documentation
* Created a Page entry type template with a sidebar content area
* Created a Page entry type template to be used as a general entry type listing (i.e. news, etc)
* Created a Page entry type template for creating quick inline redirects
* Added default sections for News & FAQs to show 
* Added a number of default Craft plugins including: Sherlock, Navigate, Spring, Redirect Manager, Environment Label, and Express Forms
* Added vue-hooper to the default JS package for creating basic, accessible sliders
* Added default SiteModule Controller and Console Controller



## 1.2.11 - 2021.09.08

### Changed
* Updated seed database




## 1.2.10 - 2021.09.08

### Removed
* Errant inclusion of work-in-progress EntryMate plugin




## 1.2.9 - 2021.08.29

### Added
* `APP_ID` field added to .env & craft/config/app.php to prevent staging server redis cache collisons
* redactor-link-class plugin for assigning class names to `<a>` links in redactor
* redactor-list-class plugin for assigning class names to `<ul>` + `<ol>` elements in redactor
* redactor-image-class plugin for assigning class names to the `<figure>` wrapper around `<img>` elements in redactor

### Changed
* Renamed `cms/template/pages` and `cms/template/blocks` to `_pages` and `_blocks` respectively so that the twig files couldn't be called by URL through the browser




## 1.2.8 - 2021.07.21
### Changed
* Added Accordion block
* Added Anchor Link field to all block types
* Added CSS for text block type `centered` & `column` layout variations
* Added CSS for iconList block type `horizontal`, `vertical`, `verticalAlternative`, & `grid` layout variations
* Added Makefile to [automate frontend tasks](https://nystudio107.com/blog/using-make-makefiles-to-automate-your-frontend-workflow)
* Added `alpha` & `omega` class names to blocks inside block loop
* Added bottom spacing: `none` option to all block types
* Added sample `block/_combinations.pcss` for storing how different blocks interact when butting up against each other
* Fixed Two Text block CSS
* Fixed typo in Hero image alt text
* Fixed breaking change in `webpack-dev-server` version upgrade
* Standardized help text on all block fields (layout/spacing/background)



## 1.2.7 - 2021.07.20
### Changed
* Updated to Craft CMS v3.7.4
* Added DevOps config helpers for Cloudways and Forge setups in src/conf
* Added default Typogrify config
* Added default page transition animation
* Added knock-knock plugin for password protected staging sites
* Added Super Table plugin and made use of it for IconList block type and button fields
* Added Typed Link Field plugin and used it to replace all button fields
* Rearranged base web layout
* Rearranged CSS files
* Rearranged News Index to be an Entry Type of the Pages Section instead of a standalone Single
* Changed all Content Block headlines to BoldOnly redactor fields
* Cleaned up default Asset folder settings
* Split buddy.yml files into staging & production versions
* Disabled Matrixmate tabs & groups
* Removed topics as a default category

## 1.2.5 - 2021.06.23
### Changed
* Fixed composer version to satisfy packagist

## 1.2.4 - 2021.06.23
### Changed
* Added several new default Content Block types: Entries, Image Only, Two Text, Icon List
* Added a Vue Modal component for loading sub-page content within a lightbox while stripping away the primary content frame
* Added default Hero Banner fields
* Additional tweaks to template structure and base CSS

## 1.2.3 - 2021.06.11
### Changed
* Minor streamlining adjustments to the base template and webpack structure

## 1.2.2 - 2021.05.20
### Fixed
* Removed the verbb navigation plugin from the initial Craft CMS `composer.json` and `project.yaml` files

## 1.2.1 - 2021.05.19
### Changed
* Updated to webpack 5
* Switched from SASS to PostCSS
* Included Tailwind


## 1.2.0 - 2021.05.18
### Changed
* Updated for Craft 3.6.14
* Reduced inheritence & reliance on [nystudio107 docker images](https://github.com/nystudio107/docker-images) while maintaining similar configuration. Mostly just to reduce complexity and cognitive load.
* Moved all possible docker images to use Alpine Linux to improve performance
* Moved webpack configuration out of `docker-config` and into `buildchain` directory
* General tidying up of directory structure


## 1.1.0 - 2020.08.04
### Added
* Updated for Craft 3.5.0


## 1.0.0 - 2020.07.18
### Added
* Initial release.
* Influenced by and heavily modified from [nystudio107/craft](https://github.com/nystudio107/craft)

