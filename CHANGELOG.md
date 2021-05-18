1.2.0# simplicate-web/craft Change Log

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
