<?php
/**
 * Site module for Craft CMS 3.x
 *
 * Custom site module
 *
 * @link      https://simplicate.ca
 * @copyright Copyright (c) 2020 simplicate
 */

namespace modules\sitemodule\helpers;

use Craft;
use craft\helpers\ArrayHelper;
use craft\helpers\StringHelper;

/**
 * @author    simplicate
 * @package   SiteModule
 * @since     1.0.0
 */
class Config
{
    // Constants
    // =========================================================================

    protected const PHP_SUFFIX = '.php';


    // Static Methods
    // =========================================================================

    /**
     * Loads a config file from, trying @craft/config first, then @modules/sitemodule
     *
     * @param string $fileName
     *
     * @return array
     */
    public static function getConfigFromFile( string $fileName ): array
    {
        $fileName  .= self::PHP_SUFFIX;
        $currentEnv = Craft::$app->getConfig()->env;

        // Try craft/config first
        $path = Craft::getAlias('@craft/config/'.$fileName, false);
        if ($path === false || !file_exists($path)) {
            // Now try our own internal config
            $path = Craft::getAlias('@modules/sitemodule/'.$fileName, false);
            if ($path === false || !file_exists($path)) {
                return [];
            }
        }

        if (!is_array($config = @include $path)) {
            return [];
        }

        // If it's not a multi-environment config, return the whole thing
        if (!array_key_exists('*', $config)) {
            return $config;
        }

        // If no environment was specified, just look in the '*' array
        if ($currentEnv === null) {
            return $config['*'];
        }

        $mergedConfig = [];
        foreach ($config as $env => $envConfig) {
            if ($env === '*' || StringHelper::contains($currentEnv, $env)) {
                $mergedConfig = ArrayHelper::merge($mergedConfig, $envConfig);
            }
        }

        return $mergedConfig;
    }
    
}
