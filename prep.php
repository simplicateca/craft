<?php

copy('./cms/.env.example', './cms/.env');
chmod('./cms/.env', 0777);
chmod('./cms/composer.json', 0777);
chmod('./cms/config', 0777);
copy('./scripts/.env.example.sh', './scripts/.env.sh');
unlink('composer.json');
unlink('composer.lock');
unlink('LICENSE.md');
unlink('README.md');
unlink('CHANGELOG.md');
unlink('.gitignore');
copy('.gitignore.prod', '.gitignore');
unlink('.gitignore.prod');

$appID  = strtoupper( preg_replace( '/[^\w+]/', '_', basename(dirname(__FILE__)) ) );
$secKey = substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(32/strlen($x)) )),1,32);
$str = file_get_contents('./cms/.env');
$str = str_replace('REPLACE_SEC_KEY', $secKey, $str);
$str = str_replace('REPLACE_APP_ID', $appID, $str);
file_put_contents('./cms/.env', $str );

unlink('prep.php');