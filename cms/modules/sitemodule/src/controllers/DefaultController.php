<?php
/**
 * Site module for Craft CMS 3.x
 *
 * Default site module
 *
 * @link      simplicate.ca
 * @copyright Copyright (c) 2020 Simplicate
 */

namespace modules\sitemodule\controllers;

use modules\sitemodule\SiteModule;

use Craft;
use craft\web\Controller;
use yii\web\Response;


/**
 * Default Controller
 *
 * Generally speaking, controllers are the middlemen between the front end of
 * the CP/website and your module’s services. They contain action methods which
 * handle individual tasks.
 *
 * A common pattern used throughout Craft involves a controller action gathering
 * post data, saving it on a model, passing the model off to a service, and then
 * responding to the request appropriately depending on the service method’s response.
 *
 * Action methods begin with the prefix “action”, followed by a description of what
 * the method does (for example, actionSaveIngredient()).
 *
 * https://craftcms.com/docs/plugins/controllers
 *
 * @author    Simplicate
 * @package   SiteModule
 * @since     1.0.0
 */
class DefaultController extends Controller
{
    // Protected Properties
    // =========================================================================

    /**
     * @var    bool|array Allows anonymous access to this controller's actions.
     *         The actions must be in 'kebab-case'
     * @access protected
     */
    protected static array $allowAnonymous = ['index'];

    // Public Methods
    // =========================================================================

    /**
     * Handle a request going to our module's index action URL,
     * e.g.: actions/site-module/default
     *
     * @return Response
     */
    public function actionIndex(): Response {
        echo "Here";
        exit;
    }
}