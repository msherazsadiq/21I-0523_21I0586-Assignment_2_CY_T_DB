USE i210523_i210586_Assignment_2_CY_T_DB;


-- 5
SELECT Product_ID, AVG(Rating) AS AverageRating
FROM Review
GROUP BY Product_ID
HAVING AVG(Rating) = (SELECT MAX(AverageRating) FROM (SELECT Product_ID, AVG(Rating) AS AverageRating FROM Review GROUP BY Product_ID) AS AvgRatings);
