CREATE USER 'ft'@'%' IDENTIFIED BY 'ft';
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'ft'@'%' IDENTIFIED BY 'ft';
FLUSH PRIVILEGES;
