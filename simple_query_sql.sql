/*Example schema
	Movies(title, year, length, genre, studioName, producer#)
	StarsIn(movieTitle, movieYear, StarName)
	MovieStar(name, address, gender, birthday)
	MovieExec(name, address, cert#, newWorth)
	Studio(name, address, presC#)*/

/*Example 1
Find all movies produced by Disney in 1990 */

SELECT *
FROM Movies
WHERE studioName = 'Disney' AND year = 1990

/*Example 2
In SELECT use name and duration in place of title and length */
SELECT title AS name, length AS duration
FROM Movies
WHERE studioName = 'Disney' AND year = 1990

/*Example 3
include aggregation in SELECT */
SELECT title AS name, length*0.016667 AS lengthInHours
FROM Movies
WHERE studioName = 'Disney' AND year = 1990

/*Example 4
include constant in SELECT result */
SELECT title AS name, length*0.016667 AS lengthInHours, 'hrs' AS 'inHours'
FROM Movies
WHERE studioName = 'Disney' AND year = 1990

/*Example 5
Pattern matching */
/* I want to find a movie start with 'star something' and something has four letters */
SELECT title
FROM Movies
WHERE title LIKE 'star _ _ _ _'

/*Example 6
Pattern matching */
/* Search titles with a possessive('s') in the movie   */
SELECT title
FROM Movies
WHERE title LIKE '%''s%'

/*Example 7
Pattern matching with % or _ as part of the string*/
/* Search titles with a possessive('s') in the movie   */
SELECT title
FROM Movies
WHERE title LIKE 'x%%x%' ESCAPE 'x'

/* something missing? try to test NULL or UNKNOWN

/* Example 8
show all the movies ordered by title and length*/
SELECT *
FROM Movies
WHERE studioName = 'Disney' and year = 1990
ORDER BY length, title

/* Example 9
order by can include expression*/
SELECT *
FROM Movies
WHERE studioName = 'Disney' and year = 1990
ORDER BY length+produced#

/*-------------------------------------------Query involving more than one relation------------------------------------------*/

/* Example 10
Cartesian product*/
SELECT name
FROM Movies, MovieExec
WHERE title = 'start wars' AND producer# = cert#

/* Example 11
disambiguating attributes*/
SELECT MovieStar.name, MovieExec.name
FROM MovieStar, MovieExec
WHERE MovieStar.address = MovieExec.address

/*Example 12
Using alias to join identical relations*/
SELECT star1.name, star2.name
FROM MovieStar AS star1, MovieStar AS star2 --can omit AS in this line
WHERE star1.address = star2.address AND star1.name < star2.name -- can not use <>, 
									     --because it will product same tuple with two name switched
/* Example 13
Union operation*/
(SELECT title, year FROM Movies)
UNION
(SELECT MovieTitle AS title, movieYear AS year)

/* Example 14
Intersection operation*/
(SELECT name, address FROM MovieStar WHERE gender = 'F')
INTERSECT
(SELECT name, address FROM MovieExec WHERE newWorth>10000000)

/* Example 15
Difference operation*/
(SELECT name, address FROM MovieStar)
ESCEPT
(SELECT name, address FROM MovieExec)

/* Example 16
Subsequence can produce constant used to do comparison in where part
Find the producer of star wars*/
SELECT name 
FROM MovieExec
WHERE cert# = (
	SELECT producer#
	FROM Movies
	WHERE title = 'star wars'
)

/* Example 17
Find the producer of Harrison Ford's Movie*/
SELECT name 
FROM MovieExec
WHERE cert# = (
	SELECT producer#
	FROM Movies
	WHERE (title, year) IN (
		SELECT MovieTitle, movieYear
		FROM StarsIn
		WHERE StarName = 'Harrison Ford'
	)
)

/* Example 18
Find movie title that appear more than once*/
SELECT old.title
FROM Movies old
WHERE old.year < ANY (
	SELECT title
	FROM Movies
	WHERE title = old.title
)

/* Example 19
Find producer of Harrison Ford's Movie*/
SELECT name 
FROM MovieExec, (
	SELECT producer#
	FROM Movies, StarsIn
	WHERE title = MovieTitle AND
		year = movieYear AND
		StarName = 'Harrison Ford'
	)prod
WHERE cert# = prod.producer

/* Example 20
Join on practice*/
SELECT title, year, length, genre, studioName, producer#, startName
FROM Movies JOIN StarsIn ON 
	title = movieTitle AND year = movieYear;

/* Example 21
Natural Join*/
MovieStar NATURAL JOIN MovieExec

/* Example 22
outer join*/
MovieStar NATURAL FULL OUTER JOIN Movies;
MovieStar NATURAL FULL OUTER JOIN Movies;
MovieStar NATURAL FULL OUTER JOIN Movies;

#outer theta-join
MovieStar FULL OUTER JOIN StarsIn ON title = movieTitle AND year = movieYear;
MovieStar LEFT OUTER JOIN StarsIn ON title = movieTitle AND year = movieYear;
MovieStar RIGHT OUTER JOIN StarsIn ON title = movieTitle AND year = movieYear;

#Example 23
#aggregation -- AVG
SELECT AVG(newWorth)
FROM MovieExec

#aggregation -- COUNT
SELECT COUNT(DISTINCT name)
FROM MovieExec

#Example 24
SELECT SUM(length)
FROM Movies
GROUP BY studioName