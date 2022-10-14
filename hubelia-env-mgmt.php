<?php
    /*
    Plugin Name: Environment Management
    Description: A plugin to push changes to the production env.
    Author: Mohamad Kredly - Hubelia
    */

    // ENV_TYPE: Enviromental variable that indicates the environment type
    // 1 = Staging (push)
    // 2 = Prod (pull)

    switch (getenv("ENV_TYPE")) {
      case 1:
        add_action ('adminmenu', 'add_hubelia_migrations');
        add_action( 'wp_ajax_push_changes', 'push_changes_callback' );
        break;
    }


    function add_hubelia_migrations() {
      include("push/push.php");
    }

    function push_changes_callback() {
      // $path = "/var/www/html/wp-content/plugins/hubelia-migrations";
      // $path = "/Applications/MAMP/htdocs/espresso-website/wp-content/plugins/hubelia-migrations";

      $path = dirname(__FILE__);

      global $wpdb; /* this is how you get access to the database */
      global $hub_migrations_db_name;

      $tablename = $wpdb->prefix . $hub_migrations_db_name;

      // shell_exec("/bin/bash /Applications/MAMP/htdocs/espresso-website/wp-content/plugins/hubelia-migrations/push/push.sh");
      $GIT_TOKEN = getenv("GIT_TOKEN");
      $SITE_REPO = getenv("REPO");
      $DB_REPO = getenv("DB_REPO");
      
      $EXTRA_REGEX = (getenv("EXTRA_REGEX") == "" ? "noregextra" : getenv("EXTRA_REGEX"));
      $DB_HOST = getenv("WORDPRESS_DB_HOST");
      $DB_USER = getenv("WORDPRESS_DB_USER");
      $DB_PASS = getenv("WORDPRESS_DB_PASSWORD");
      $DB_NAME = getenv("WORDPRESS_DB_NAME");

      $ENC_KEY = getenv("MYSQL_ENC_KEY");

      $VERSION = bloginfo('version');

      $response = null;

      // DB + Files
      exec("/bin/bash $path/push/push.sh $EXTRA_REGEX $DB_HOST $DB_USER $DB_PASS $DB_NAME $ENC_KEY $GIT_TOKEN $SITE_REPO $DB_REPO $VERSION", $response);

      $response = "Pushed Changes !";
      // echo implode("\n", $response);
      echo($response);
      wp_die(); /* this is required to terminate immediately and return a proper     response */
    }
?>
