
[![WordPress+Docker](https://banck.net/wp-content/uploads/2015/08/Wordpress_Docker.png "WordPress+Docker")](https://banck.net/wp-content/uploads/2015/08/Wordpress_Docker.png "WordPress+Docker")
# *How to start the WordPress server with Docker?*

------------
- If it's the very first time of running it, create a ***.env*** file in the root folder by copying the ***.env.sample*** file.
- Assign values for the environment variables in ***.env*** file.
- The **MYSQL_DATABASE** variable is used to name the WordPress database name. It will be used while configuring the WordPress dashboard
- The **MYSQL_ROOT_PASSWORD** variable is used to define the password of the root user account for mysql database.
  > If password is set to **secret-password**, than WordPress config credentials would be 
  **Mysql user:** root
  **Mysql password:** secret-password
-  The server will start & can be accessed by **localhost:4000**
-  The **Database Host** for WordPress would be the **MYSQL_DATABASE** environment variable value
- Set a table prefix for the WordPress site & click Submit to create the WordPress environment

### Check the Makefile to see other available commands
