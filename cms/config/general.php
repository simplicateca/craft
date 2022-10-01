<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

use craft\config\GeneralConfig;
use craft\helpers\App;

return GeneralConfig::create()
    // Enable Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
    ->devMode( (App::env('CRAFT_ENVIRONMENT') != 'production') )

    // run the queue automatically (or do we have a cron job setup)
    ->runQueueAutomatically( ( App::env('RUN_QUEUE') == 'auto' ) )

    // Allow administrative changes
    ->allowAdminChanges( (App::env('CRAFT_ENVIRONMENT') != 'production') )
    
    // Disallow robots
    ->disallowRobots( (App::env('CRAFT_ENVIRONMENT') != 'production') )

    ->aliases([
        '@assetsUrl' => App::env('ASSETS_URL'),
        '@cdnUrl' => App::env('CDN_URL'),
        '@cdnFolder' => App::env('CDN_FOLDER'),
        '@web' => App::env('SITE_URL'),
        '@webroot' => App::env('WEB_ROOT_PATH'),
    ])

    // Set the default week start day for date pickers (0 = Sunday, 1 = Monday, etc.)
    ->defaultWeekStartDay(1)

    // Prevent generated URLs from including "index.php"
    ->omitScriptNameInUrls()

    // improve save speed by limiting the number of revisions we save
    ->maxRevisions(10)

    ->defaultSearchTermOptions([
        'subLeft'  => true,
        'subRight' => true,
    ])

    ->errorTemplatePrefix('errors/')

    // 100MB
    ->maxUploadFileSize(104857600)
    
    ->useEmailAsUsername(true)

;
