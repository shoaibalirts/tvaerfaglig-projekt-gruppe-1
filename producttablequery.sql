CREATE DATABASE vue_product_page;
use vue_product_page;
show tables;
CREATE TABLE product (prod_id INTEGER, prod_name VARCHAR(50),
       prod_co2 INTEGER);
       
CREATE TABLE user (user_id INTEGER PRIMARY KEY auto_increment, user_name VARCHAR(50),
       user_password VARCHAR(50), user_role_name VARCHAR(50));
DROP TABLE message;

CREATE TABLE message (
  msg_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_user_id INT NOT NULL,
  receiver_user_id INT NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_user_id) REFERENCES user(user_id),
  FOREIGN KEY (receiver_user_id) REFERENCES user(user_id)
);



SELECT * FROM product;
SELECT * FROM user;
SELECT * FROM message;
SELECT * FROM message WHERE sender_user_id=5;
DELETE FROM user
WHERE user_id = 8;

SELECT user_id, msg_id, the_user_message FROM message; 
SELECT user_id, user_name, user_password, user_role_name FROM user;

    

INSERT INTO user 
	(user_name, user_password, user_role_name) 
	VALUES 
    ('marta', '123', 'admin'),
	('sofie', '1234', 'projectleder'),
    ('sufian', '12345', 'CTO'),
    ('shoaib', '123456', 'Softwareudvikler');
SELECT * FROM user;

ALTER TABLE product DROP COLUMN prod_id;
ALTER TABLE product DROP COLUMN prod_co2;
ALTER TABLE product
ADD prod_co2 FLOAT(4,2);
ALTER TABLE product
ADD prod_id INTEGER PRIMARY KEY auto_increment;
ALTER TABLE product
ADD curr_date DATE;
ALTER TABLE user DROP COLUMN prod_id;

ALTER TABLE user
MODIFY COLUMN user_password VARCHAR(254);

ALTER TABLE user
ADD COLUMN user_message VARCHAR(254);



ALTER TABLE user DROP COLUMN user_message;

INSERT INTO product 
(prod_name, prod_co2, curr_date)
VALUES
('banana', 2, current_date());
INSERT INTO product 
(prod_name, prod_co2, curr_date)
VALUES
('Potato', 3, current_date());
INSERT INTO product 
(prod_name, prod_co2, curr_date)
VALUES
('Kylling', 8, current_date());
INSERT INTO product 
(prod_name, prod_co2, curr_date)
VALUES
('Lammekød', 12, current_date());

INSERT INTO product 
(prod_name, prod_co2, curr_date2)
VALUES
('Avocado', 3, current_date());
INSERT INTO product 
(prod_name, prod_co2, curr_date)
VALUES
('Kaki', 3.4, current_date());
INSERT INTO product 
(prod_name, prod_co2, curr_date)
VALUES
('Krtofler', 4.5, current_date());
SELECT prod_id, prod_name, prod_co2, curr_date FROM product;
SELECT prod_id, prod_name, prod_co2, curr_date FROM product WHERE prod_id=2;

TRUNCATE TABLE product;

-- 1. Change the authentication plugin for the user
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '9602';

-- 2. Flush privileges for the change to take effect immediately
FLUSH PRIVILEGES;
