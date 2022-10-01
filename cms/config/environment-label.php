<?php

$isAdmin = ( Craft::$app->getUser()->getIdentity()->admin ?? null );

return [
    '*' => [
        'showLabel'      => ($isAdmin),
        'labelText'      => "LIVE SITE",
        'prefixText'     => "{{siteName}} --- ",
        'suffixText'     => " --- {{siteUrl|replace('https://','')|replace('http://','')|trim('/', 'right')}}",
        'labelColor'     => '#48c78e',
        'textColor'      => '#ffffff',
        'targetSelector' => '#global-header:before',
    ],
    
    'staging' => [
        'showLabel'  => true,
        'labelColor' => '#ffe08a',
        'labelText'  => "STAGING SERVER",
        'textColor'  => '#000000b3',
    ],

    'dev' => [
        'showLabel'  => true,
        'labelText'  => "LOCAL DEV",
        'labelColor' => '#cc5643',
    ],
];