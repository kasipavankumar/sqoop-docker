# Restart MySQL service.
service mysql restart

# Download & unzip a sample database in MySQL.
# https://dev.mysql.com/doc/employee/en/employees-installation.html
wget https://github.com/datacharmer/test_db/archive/refs/heads/master.zip \
&& unzip master.zip

# Switch to sample database directory &
# load the database into MySQL.
cd test_db-master \
&& mysql < employees.sql

# Validate the loaded database.
# https://dev.mysql.com/doc/employee/en/employees-validation.html
# time mysql -t < test_employees_sha.sql \
# && time mysql -t < test_employees_md5.sql

# Return back to home.
cd /

# Boot Hadoop services.
# (This also leaves user with the shell.)
./bootstrap.sh
