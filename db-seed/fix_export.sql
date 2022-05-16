-- this code fixes an error that was occuring when attempting to export using mysqldump
-- it has something to do with a change in the password encryption on mysql8
-- https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded
-- it should only need to run once, and should trigger automatically when the mysqlserver8 docker container first builds
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'project'@'%' IDENTIFIED WITH mysql_native_password BY 'project';