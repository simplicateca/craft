# simplicate-web/craft Change Log

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

