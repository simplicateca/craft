<?php
/**
 * Site module for Craft CMS 3.x
 *
 * @link      www.simplicate.ca
 * @copyright Copyright (c) 2022
 */

namespace modules\sitemodule\twigextensions;

use modules\sitemodule\SiteModule;

use Craft;

use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;
use Twig\TwigFunction;

use Masterminds\HTML5;
use Symfony\Component\DomCrawler\Crawler;

/**
 * Twig can be extended in many ways; you can add extra tags, filters, tests, operators,
 * global variables, and functions. You can even extend the parser itself with
 * node visitors.
 *
 * http://twig.sensiolabs.org/doc/advanced.html
 *
 * @author    Steve Comrie
 * @package   SiteModule
 * @since     1
 */
class SiteModuleTwigExtension extends AbstractExtension
{
    // Public Methods
    // =========================================================================

    /**
     * Returns the name of the extension.
     *
     * @return string The extension name
     */
    public function getName()
    {
        return 'SiteModule';
    }

    /**
     * Returns an array of Twig filters, used in Twig templates via:
     *
     *      {{ 'something' | someFilter }}
     *
     * @return array
     */
    public function getFilters()
    {
        return [
            new TwigFilter( 'extractLeadingHeaders', [$this, 'extractHeaders',  ]),
            new TwigFilter( 'removeLeadingHeaders',  [$this, 'removeHeaders'  ]),
        ];
    }

    /**
     * Returns an array of Twig functions, used in Twig templates via:
     *
     *      {% set this = someFunction('something') %}
     *
    * @return array
     */
    public function getFunctions()
    {
        return [
            new TwigFunction('leadingHeaders', [$this, 'leadingHeaders']),
        ];
    }


    public function extractHeaders( $html = "" ) {
        return $this->leadingHeaders( $html, 'extract' );
    }

    public function removeHeaders( $html = "" ) {
        return $this->leadingHeaders( $html, 'remove' );
    }

    /**
     * Finds any leading header tags (h1-h6) at the beginning of a string of
     * HTML code and optionally extract or removes them, returning the result
     *
     * @param string $html -- a block of well formatted html code
     *
     * @return string
     */
    public function leadingHeaders( $html = "", $method = 'extract' )
    {
        $libxmlUseInternalErrors = \libxml_use_internal_errors(true);
        $content = \mb_convert_encoding($html, 'HTML-ENTITIES', Craft::$app->getView()->getTwig()->getCharset());
        $doc = new \DOMDocument();       
        $doc->loadHTML("<html><body>$content</body></html>", LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
        \libxml_use_internal_errors($libxmlUseInternalErrors);

        $crawler = new Crawler($doc);

        if( $crawler->filter('body') && $crawler->filter('body')->children() ) {
            $html = "";
            $foundLeading = false;
            
            foreach( $crawler->filter('body')->children() AS $node ) {
                if( !$foundLeading && in_array( strtolower( $node->tagName ), ['h1','h2','h3','h4','h5','h6'] ) ) {
                    $html .= ( $method == 'extract' ) ? $node->ownerDocument->saveHTML($node) : "";
                } else {
                    $foundLeading = true;
                    $html .= ( $method == 'remove'  ) ? $node->ownerDocument->saveHTML($node) : "";
                }
            }
        }

        return $html;
    }
}
