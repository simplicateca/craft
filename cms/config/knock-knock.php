<?php

return [
    '*' => [
        'enabled' => false,
        'loginPath' => 'knock-knock/who-is-there',
        'template' => '',
        'forcedRedirect' => '',
        'password' => 'letmein',
        'siteSettings' => [],

        'checkInvalidLogins' => false,
        'invalidLoginWindowDuration' => '3600',
        'maxInvalidLogins' => 10,
        'allowIps' => '',
        'denyIps' => '',
        'useRemoteIp' => false,
        
        'protectedUrls' => '',
        'unprotectedUrls' => '',
    ],
    'staging' => [
        'enabled' => true,
    ],
];