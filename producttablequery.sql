-- -- CREATE DATABASE vue_product_page;
-- -- use vue_product_page;
-- -- CREATE DATABASE sofieroshni_dk_db;
-- -- use sofieroshni_dk_db;
-- CREATE TABLE IF NOT EXISTS ...

-- show tables;
-- CREATE TABLE product (prod_id INTEGER, prod_name VARCHAR(50),
--        prod_co2 INTEGER);
       
-- CREATE TABLE user (user_id INTEGER PRIMARY KEY auto_increment, user_name VARCHAR(50),
--        user_password VARCHAR(50), user_role_name VARCHAR(50));
-- INSERT INTO user 
-- 	(user_name, user_password, user_role_name) 
-- 	VALUES 
--     ('marta', '123', 'admin'),
-- 	('sofie', '1234', 'projectleder'),
--     ('sufian', '12345', 'CTO'),
--     ('shoaib', '123456', 'Softwareudvikler');
-- SELECT * FROM user;

-- ALTER TABLE product DROP COLUMN prod_id;
-- ALTER TABLE product DROP COLUMN prod_co2;
-- ALTER TABLE product
-- ADD prod_co2 FLOAT(4,2);
-- ALTER TABLE product
-- ADD prod_id INTEGER PRIMARY KEY auto_increment;
-- ALTER TABLE product
-- ADD curr_date DATE;
-- SELECT * FROM product;
-- SELECT * FROM user;

-- ALTER TABLE user
-- MODIFY COLUMN user_password VARCHAR(254);

-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date)
-- VALUES
-- ('banana', 2, current_date());
-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date)
-- VALUES
-- ('Potato', 3, current_date());
-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date)
-- VALUES
-- ('Kylling', 8, current_date());
-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date)
-- VALUES
-- ('Lammekød', 12, current_date());

-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date2)
-- VALUES
-- ('Avocado', 3, current_date());
-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date)
-- VALUES
-- ('Kaki', 3.4, current_date());
-- INSERT INTO product 
-- (prod_name, prod_co2, curr_date)
-- VALUES
-- ('Krtofler', 4.5, current_date());
-- SELECT prod_id, prod_name, prod_co2, curr_date FROM product;
-- SELECT prod_id, prod_name, prod_co2, curr_date FROM product WHERE prod_id=2;

-- TRUNCATE TABLE product;

-- -- 1. Change the authentication plugin for the user
-- -- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '9602';
-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'R4FA35tEDcgk2xe6fGbd 
-- ';


-- -- 2. Flush privileges for the change to take effect immediately
-- FLUSH PRIVILEGES;
-- Opret tabeller

CREATE TABLE IF NOT EXISTS product (
    prod_id INT AUTO_INCREMENT PRIMARY KEY,
    prod_name VARCHAR(50),
    prod_co2 FLOAT(4,2),
    curr_date DATE
);

CREATE TABLE IF NOT EXISTS user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50),
    user_password VARCHAR(254),
    user_role_name VARCHAR(50)
);

-- Indsæt brugere
INSERT INTO user (user_name, user_password, user_role_name) VALUES
('marta', '123', 'admin'),
('sofie', '1234', 'projectleder'),
('sufian', '12345', 'CTO'),
('shoaib', '123456', 'Softwareudvikler');

-- Indsæt produkter
INSERT INTO product (prod_name, prod_co2, curr_date) VALUES
('banana', 2, current_date()),
('Potato', 3, current_date()),
('Kylling', 8, current_date()),
('Lammekød', 12, current_date()),
('Avocado', 3, current_date()),
('Kaki', 3.4, current_date()),
('Kartofler', 4.5, current_date());

-- Vis data
SELECT * FROM user;
SELECT * FROM product;
