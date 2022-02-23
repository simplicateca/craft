<?php
/**
 * Site module for Craft CMS 3.x
 *
 * Custom site module
 *
 * @link      https://simplicate.ca
 * @copyright Copyright (c) 2020 simplicate
 */

namespace modules\sitemodule;

use modules\sitemodule\assetbundles\sitemodule\SiteModuleAsset;
use modules\sitemodule\services\Helper;
use modules\sitemodule\variables\SiteVariable;

use Craft;
use craft\events\RegisterTemplateRootsEvent;
use craft\events\TemplateEvent;
use craft\console\Application as ConsoleApplication;
use craft\i18n\PhpMessageSource;
use craft\web\UrlManager;
use craft\events\RegisterUrlRulesEvent;
use craft\web\twig\variables\CraftVariable;
use craft\web\View;

use craft\redactor\Field AS RedactorField;

use yii\base\Event;
use yii\base\InvalidConfigException;
use yii\base\Module;

/**
 * Class SiteModule
 *
 * @author    simplicate
 * @package   SiteModule
 * @since     1.0.0
 *
 * @property Helper helper
 */
class SiteModule extends Module
{
    // Static Properties
    // =========================================================================

    /**
     * @var SiteModule
     */
    public static $instance;

    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function __construct($id, $parent = null, array $config = [])
    {
        Craft::setAlias('@modules/sitemodule', $this->getBasePath());
        $this->controllerNamespace = 'modules\sitemodule\controllers';

        // Translation category
        $i18n = Craft::$app->getI18n();
        /** @noinspection UnSafeIsSetOverArrayInspection */
        if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id.'*'])) {
            $i18n->translations[$id] = [
                'class' => PhpMessageSource::class,
                'sourceLanguage' => 'en-US',
                'basePath' => '@modules/sitemodule/translations',
                'forceTranslation' => true,
                'allowOverrides' => true,
            ];
        }

        // Base template directory
        Event::on(View::class, View::EVENT_REGISTER_CP_TEMPLATE_ROOTS, function (RegisterTemplateRootsEvent $e) {
            if (is_dir($baseDir = $this->getBasePath().DIRECTORY_SEPARATOR.'templates')) {
                $e->roots[$this->id] = $baseDir;
            }
        });

        // Set this as the global instance of this module class
        static::setInstance($this);

        parent::__construct($id, $parent, $config);
    }


    /**
     * @inheritdoc
     */
    public function init()
    {
        parent::init();
        self::$instance = $this;

        // Add in our console commands
        if (Craft::$app instanceof ConsoleApplication) {
            $this->controllerNamespace = 'modules\sitemodule\console\controllers';
        }

        // register our components
        $this->setComponents([
            'helper' => [
                'class' => Helper::class,
            ]
        ]);

        // register our variables
        Event::on(
            CraftVariable::class,
            CraftVariable::EVENT_INIT,
            function (Event $event) {
                /** @var CraftVariable $variable */
                $variable = $event->sender;
                $variable->set('site', SiteVariable::class);
            }
        );


        // Register our site routes
        Event::on(
            UrlManager::class,
            UrlManager::EVENT_REGISTER_SITE_URL_RULES,
            function (RegisterUrlRulesEvent $event) {
                $event->rules['module-route'] = 'site-module/default/index';
            }
        );

        
        // if we're on the control panel
        if (Craft::$app->getRequest()->getIsCpRequest()) {
            
            // register our Asset bundle for CP requests
            Event::on(
                View::class,
                View::EVENT_BEFORE_RENDER_TEMPLATE,
                function (TemplateEvent $event) {
                    try {
                        Craft::$app->getView()->registerAssetBundle(SiteModuleAsset::class);
                    } catch (InvalidConfigException $e) {
                        Craft::error(
                            'Error registering AssetBundle - '.$e->getMessage(),
                            __METHOD__
                        );
                    }
                }
            );

            // register html purifier config changes
            Event::on(
                RedactorField::class,
                RedactorField::EVENT_MODIFY_PURIFIER_CONFIG,
                function (Event $event) {
                    if( $event->config ) {
                        if( $def = $event->config->getDefinition('HTML', true) ) {
                            $def->addAttribute('a', 'aria-label',    'Text');
                            $def->addAttribute('a', 'data-tracking', 'Text');
                        }
                    }
                }
            );
        }


        Craft::info(
            Craft::t(
                'site-module',
                '{name} module loaded',
                ['name' => 'Site']
            ),
            __METHOD__
        );
    }

    // Protected Methods
    // =========================================================================
}
