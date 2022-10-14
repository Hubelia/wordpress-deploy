<?php


if ( $_POST['payload'] ) {
  // Only respond to POST requests from Github

    $DB_HOST = getenv("WORDPRESS_DB_HOST");
    $DB_USER = getenv("WORDPRESS_DB_USER");
    $DB_PASS = getenv("WORDPRESS_DB_PASSWORD");
    $DB_NAME = getenv("WORDPRESS_DB_NAME");

    $ENC_KEY = getenv("MYSQL_ENC_KEY");

    // Run script
    exec("/bin/bash ".dirname(__FILE__)."/pull.sh $DB_HOST $DB_USER $DB_PASS $DB_NAME $ENC_KEY");

    die("done " . mktime());
}

?>