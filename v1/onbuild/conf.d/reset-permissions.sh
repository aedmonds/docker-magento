#!/bin/bash

MAGENTO_HOME=/var/www/html/magento

chown -R www-data $MAGENTO_HOME
find $MAGENTO_HOME -type f -exec chmod 400 {} \;
find $MAGENTO_HOME -type d -exec chmod 500 {} \;
find $MAGENTO_HOME/var/ -type f -exec chmod 600 {} \;
find $MAGENTO_HOME/media/ -type f -exec chmod 600 {} \;
find $MAGENTO_HOME/var/ -type d -exec chmod 700 {} \;
find $MAGENTO_HOME/media/ -type d -exec chmod 700 {} \;
chmod 700 $MAGENTO_HOME/includes
chmod 600 $MAGENTO_HOME/includes/config.php
