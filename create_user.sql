-- Create a new user. 
CREATE USER 'bda'@'localhost' IDENTIFIED BY '123456';

-- Grant "ALL PRIVILEGES" only on the "employees" database.
GRANT ALL ON employees.* TO 'bda'@'localhost';
