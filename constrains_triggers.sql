#Example 1
#declare foreign key way1
CREATE TABLE Studio(
	name CHAR(30) PRIMARY kEY,
	address VARCHAR(255),
	prescN INT REFERNCES MovieExec(certN)
);

#Example 2
#declare foreign key way2
CREATE TABLE Studio(
	name CHAR(30) PRIMARY kEY,
	address VARCHAR(255),
	prescN INT
	FOREIGN KEY (prescN) REFERNCES MovieExec(certN)
);

#Example 3
#choosing policies to preserve integrity
CREATE TABLE Studio(
	name CHAR(30) PRIMARY kEY,
	address VARCHAR(255),
	prescN INT REFERNCES MovieExec(certN)
	ON DELETE SET NULL,
	ON UPDATE CASCADE
);

#Example 4
#check will be deferred just before each commit
CREATE TABLE Studio(
	name CHAR(30) PRIMARY kEY,
	address VARCHAR(255),
	prescN INT REFERNCES MovieExec(certN) NOT NULL -- prescN can not be NULL
	DEFERRABLE INITIALLY DEFFERED
);

#Example 5
#attributes check constrain -- check gender in 'F' or 'M' and check birthday > 1990-01-01
CREATE TABLE MovieStar(
	name CHAR(30) PRIMARY kEY,
	address VARCHAR(255),
	gender CHAR(1) CHECK(gender IN ('F', 'M')),
	birthday DATE CHECK (birthday > (1990-01-01))
)

#Example 6
#New check about prescN
CREATE TABLE Studio(
	name CHAR(30) PRIMARY kEY,
	address VARCHAR(255),
	prescN INT REFERNCES MovieExec(certN) CHECK (prescN in (SELECT certN FROM MovieExec))
	ON DELETE SET NULL,
	ON UPDATE CASCADE
);

#Example 7
#Assertion
#No one can be president of studio without net worth > 100000000
CREATE ASSERTION RichPres CHECK(
	NOT EXISTS(
		SELECT Studio.name
		FROM Studio, MovieExec
		WHERE prescN = certN AND networth <100000000
	)
)

#Example 8
#Assertion
#The total length of all films by a studio shall not exceed 10000 minutes
CREATE ASSERTION totalLength CHECK(
	10000 > ALL(SELECT SUM(length) FROM Movies GROUP BY studioName)
)

#Example 9
#Trigger
CREATE TRIGGER NetWorthTrigger -- tuple level trigger
AFTER UPDATE OF networth ON MovieExec
REFERENCING
	OLD ROW AS OldTuple
	NEW ROW AS NewTuple
FOR EACH ROW
WHEN(OLDTuple.networth>NEWTuple.networth)
	UPDATE MovieExec
	SET networth = OLDTuple
	WHERE OLDTuple.certN = NEWTuple.certN;

#Example 10
#constraining the average net worth -- statement level trigger
CREATE TRIGGER AvgNetWorthTrigger
AFTER UPDATE OF networth ON MovieExec
REFERNCING
	OLD TABLE AS OldStuff
	NEW TABLE AS NewStuff
FOR EACH STATEMENT 
WHEN(500000>(SELECT AVG(netWorth) FROM MovieExec)
BEGIN
	DELETE FROM MovieExec
	WHERE (name, address, certN, netWorth) IN NewStuff;
	INSERT INTO MovieExec
	(SELECT * FROM OldStuff);
END;

#Example 11
#fix nulls in insertion operation
CREATE TRIGGER FixYearTrigger
BEFORE INSERT ON Movies
REFERNCING
	NEW Tuple AS NewRow
	NEW Table AS NewStuff
FOR EACH ROW
BEGIN
	WHEN NewRow.year = NULL
	UPDATE NewStuff SET year 1915;
END;