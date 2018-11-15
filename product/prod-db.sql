/* 
 * MySQL Script - initializeDataBase.sql.
 * Create EMPLOYEE_RECORDS database and EMPLOYEES table.
 */
 
-- Create EMPLOYEE_RECORDS database
CREATE DATABASE IF NOT EXISTS product_info;     

-- Switch to EMPLOYEE_RECORDS database
USE product_info;

-- create EMPLOYEES table in the database
CREATE TABLE IF NOT EXISTS Product (id VARCHAR(50), name VARCHAR(50), description VARCHAR(50), price FLOAT(24)); 

INSERT INTO Product (id, name, description, price) VALUES ("100105", "Apple iPhone XS Max", "Fully Unlocked 6.5, 256 GB - Gold", 1405.00);