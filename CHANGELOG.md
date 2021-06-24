# simplicate-web/craft Change Log

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
