# ==================================
#         Development config
# ==================================
# Start the both client & server container with new build
build:
	sudo rm -rf wordpress/wp-config.php && sudo rm -rf mysql && docker-compose -f docker-compose.dev.yml up -d --build

# Start the server container
start:
	true > logs/xdebug.log && docker-compose -f docker-compose.dev.yml up -d

# Stop the server container
stop:
	true > logs/xdebug.log && docker-compose -f docker-compose.dev.yml down

stop-all-container:
	docker stop $(docker ps -a -q)

remove-images:
	docker system prune -a --volumes