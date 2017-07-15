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

/*Classes(class, type, country, numGuns, bore, displacement)
Ships(name, class, launched)
Battles(name, date)
Outcomes(ship, battle, result)*/

CREATE TABLE CLASSES(
	class		VARCHAR(50) PRIMARY KEY,
	type		CHAR(2),
	country		VARCHAR(100),
	numGuns	INT,
	bore		DECIMAL(6,2),
	displacement	DECIMAL(10,2)
)

CREATE TABLE SHIPS(
	name		VARCHAR(50),
	class                VARCHAR(50),
	launched	DATE,
	PRIMARY KEY	(name, class),
)

CREATE TABLE BATTLES(
	name		VARCHAR(50) PRIMARY KEY,
	date 		DATE
)

CREATE TABLE OUTCOMES(
	ship 		VARCHAR(50),
	battle 		VARCHAR(50),
	result 		CHAR(10),
	UNIQUE (ship, battle)
)

/*An alteration to your Classes relation from (a) to delete the attribute bore.*/
ALTER TABLE CLASSES DROP bore;

/*An alteration to your Ships relation from (b) to include the attribute yard giving the shipyard where the ship was built. */
ALTER TABLE SHIPS yard VARCHAR(100);