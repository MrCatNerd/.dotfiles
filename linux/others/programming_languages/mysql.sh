sudo apt-get update -y

# to install the MySQL Workbench:
sudo apt-get install mysql-workbench-community -y
# To install the shared client libraries:
sudo apt-get install libmysqlclient21 -y

sudo apt-get install mysql-server -y

# If you want to know where all the installed MySQL files are located
dpkg -L mysql-server

printf "MySQL config at:\n/etc/mysql/my.cnf\n/etc/mysql/conf.d/\n"

echo "Starting MySQL service"
sudo systemctl start mysql

echo "MySQL service status"
sudo systemctl status mysql

printf "MySQL server port: "
printf netstat -tlpn | grep mysql
print "\n"

echo "Starting secure installaiton script"
sudo mysql_secure_installation

echo "--------------------------------"
mysql --version
echo "--------------------------------"

printf "TO SET PASSWORD FOR ROOT USER:\nCREATE USER \"mrcat\"@\"localhost\" IDENTIFIED BY \"supersecretpassword\";\nTHIS MAY NOT BE REQUIRED\n"
echo "type \"exit\" to quit MySQL shell"
sudo mysql -u root -p

echo "for more informatio see: https://likegeeks.com/mysql-on-linux-beginners-tutorial/#Install_MySQL_on_Linux_Ubuntu_and_CentOS"

