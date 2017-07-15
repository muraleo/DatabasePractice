/*Product(maker, model, type)
PC(model, speed, ram, hd, price)
Laptop(model, speed, ram, hd, screen, price)
Printer(model, color, type, price)*/

CREATE TABLE PRODUCT(
	maker	INT,
	model	VARCHAR(100) PRIMARY KEY,
	type	VARCHAR(100)
)

CREATE TABLE PC(
	model	VARCHAR(100) PRIMARY KEY,
	speed	INT,
	ram	INT,
	hd	INTEGER, /* which is equals to INT*/
	price	INT
)

CREATE TABLE LAPTOP(
	model VARCHAR(100) PRIMARY KEY,
	speed	INT,
	ram	INT,
	hd	INT,
	screen	INT,
	price	INT
)

CREATE TABLE PRINTER(
	model VARCHAR(100) PRIMARY KEY,
	color	CHAR(10),
	type	CHAR(10),
	price	INT
)

/*An alteration to your Printer schema from (d) to delete the attribute color. */
ALTER TABLE PRINTER DROP color; /*remember ; */

/*An alteration to your Laptop schema from (c) to add the attribute od
(optical-disk type, e.g., cd or dvd). Let the default value for this attribute
be 'none' if the laptop does not have an optical disk.*/

ALTER TABLE LAPTOP ADD od CHAR(5) DEFAULT 'none';