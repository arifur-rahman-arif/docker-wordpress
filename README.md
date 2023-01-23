[![Docker](https://storage.googleapis.com/static.ianlewis.org/prod/img/docker/large_v-trans.png "Docker")](https://storage.googleapis.com/static.ianlewis.org/prod/img/docker/large_v-trans.png "Docker")

[![WordPress](https://1000logos.net/wp-content/uploads/2017/05/WordPress-Logo.png "WordPress")](https://1000logos.net/wp-content/uploads/2017/05/WordPress-Logo.png "WordPress") 


# *How to start the WordPress server?*

------------
- If it's the very first time of running it, create a ***.env*** file in the root folder by copying the ***.env.sample*** file.
- Assign values for the environment variables in ***.env* ** file.
- The **MYSQL_DATABASE** variable is used to name the WordPress database name. It will be used while configuring the WordPress dashboard
- The **MYSQL_ROOT_PASSWORD** variable is used to define the password of the root user account for mysql database.
> If password is set to **secret-password**, than WordPress config credentials would be 
**Mysql user:** root
**Mysql password:** secret-password

-  The server will start & can be accessed by **localhost:4000**
-  The **Database Host** for WordPress would be the mysql container ID.
> To get the container ID of mysql run ***docker ps*** command in terminal and copy the **CONTAINER ID** of **{database_name}_mysql** & paste it in WordPress **Database Host** field.

- Set a table prefix for the WordPress site & click Submit to create the WordPress environment

### Check the Makefile to see other available commands
