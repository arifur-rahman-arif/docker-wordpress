#!/bin/sh

DATABASE_NAME=$(echo $CI_COMMIT_REF_SLUG | tr - _)

echo '
ssh $SERVER_USER@$SERVER_IP "docker ps -aq | xargs docker stop | xargs docker rm || true"

ssh $SERVER_USER@$SERVER_IP "docker system prune -af --volumes"

ssh $SERVER_USER@$SERVER_IP "echo "$DOCKER_DEPLOY_TOKEN" | docker login -u $DOCKER_DEPLOY_USER $CI_REGISTRY --password-stdin"

ssh $SERVER_USER@$SERVER_IP "docker pull $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-php && docker pull $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-nginx && docker pull $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-mysql"

ssh $SERVER_USER@$SERVER_IP "docker run -d -p 9000:9000 -v /var/www/prod-config/wp-config.php:/usr/share/nginx/html/wp-config.php --name php $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-php"

ssh $SERVER_USER@$SERVER_IP "docker run -d -p 3306:3306 -v /var/lib/mysql:/var/lib/mysql --env MYSQL_HOST=mysql --env MYSQL_DATABASE=$MYSQL_DATABASE --env MYSQL_USER=$MYSQL_USER --env MYSQL_PASSWORD=$MYSQL_USER_PASS --env MYSQL_ROOT_PASSWORD=$MYSQL_USER_PASS --name mysql $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-mysql"

ssh $SERVER_USER@$SERVER_IP "docker run -d -p 4000:80 -v /var/www/prod-config/wp-config.php:/usr/share/nginx/html/wp-config.php --name nginx $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-nginx"

exit
' > $CI_COMMIT_REF_SLUG-clone-wordpress-db.sh
