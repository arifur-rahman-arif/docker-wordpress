which curl || apk add curl

curl -SL https://github.com/docker/compose/releases/download/v2.11.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

echo "$DOCKER_DEPLOY_TOKEN" | docker login -u $DOCKER_DEPLOY_USER $CI_REGISTRY --password-stdin > /dev/null

docker-compose -f docker-compose.prod.yml build

docker tag $CI_PROJECT_NAME-php:latest $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-php

docker tag $CI_PROJECT_NAME-nginx:latest $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-nginx

docker tag $CI_PROJECT_NAME-mysql:latest $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID-mysql

docker rmi $CI_PROJECT_NAME-php:latest $CI_PROJECT_NAME-nginx:latest $CI_PROJECT_NAME-mysql:latest

docker push --all-tags $CI_REGISTRY_IMAGE

