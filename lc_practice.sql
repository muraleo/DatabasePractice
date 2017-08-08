#1 -------- ORDER BY | != | % mod
#select odd id and not boring movie, order by rating
SELECT *
FROM CINEMA
WHERE ID%2!=0 AND DESCRIPTION != "BORING"
ORDER BY RATING DESC