# ==================================
#         Development config
# ==================================

# Start the server container with new build
start-build:
	sudo chmod 777 -R * && sudo rm -rf wordpress/wp-config.php && sudo rm -rf mysql && sudo docker-compose -f docker-compose.yml up -d --build && sudo chmod 777 -R mysql/

# Start the server container
start:
	sudo docker-compose -f docker-compose.yml up -d && sudo chmod 777 -R mysql/

# Re-start the server container
re-start:
	sudo docker-compose -f docker-compose.yml restart && sudo chmod 777 -R mysql/

# Stop the server container
stop:
	sudo docker-compose -f docker-compose.yml down && sudo chmod 777 -R mysql/

stop-all-container:
	docker stop $(docker ps -a -q)

remove-images:
	sudo docker system prune -a --volumes


# docker exec -it 89a8b153eb60 wp acf import /home/ar-arif/Workspace/next-js-sites/my-iclinic-client/data/acf-export.json --allow-root
