<?php

    add_action('admin_bar_menu', 'add_item', 100);

    function add_item( $admin_bar ){
        global $pagenow;
        $args = array(
            'id'=>'push',
            'title'=>'Push Changes',
            'href'=>''
        );
        $admin_bar->add_menu( $args );
    }

    add_action( 'admin_footer', 'push_changes_action_js' );

    function push_changes_action_js() {?>
        <script type="text/javascript" >
           jQuery("li#wp-admin-bar-push .ab-item").on( "click", function() {
              var data = {
                            'action': 'push_changes',
              };

              jQuery.post(ajaxurl, data, function(response) {
                 alert( response );
              });

            });
        </script> <?php
      }

?>