/**
 * Site module for Craft CMS
 *
 * Site JS
 *
 * @author    simplicate
 * @copyright Copyright (c) 2020 simplicate
 * @link      https://simplicate.ca/
 * @package   SiteModule
 * @since     1.0.0
 */


// move the Entry Type dropdown from the sidebar to above the content
if( entryTypeSelect = document.querySelector('body.edit-entry #entryType-field') ) {
    document.querySelector('body.edit-entry #content-container').prepend(entryTypeSelect);
}