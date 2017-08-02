/*General SELECTS for debugging*/
SELECT * FROM movie_tbl;
SELECT * FROM reviewer_tbl;
SELECT * FROM rating_tbl;

SELECT * FROM rating_tbl NATURAL JOIN movie_tbl NATURAL JOIN reviewer_tbl;

/* Exercise 1: For each movie, return the title and the 'rating spread', 
   that is, the difference between highest and lowest ratings given to
   that movie. Sort by rating spread from highest to lowest, then by
   movie title.
   */
SELECT 
    (MAX(rating.Stars_PK) - MIN(rating.Stars_PK)), movie.Title
FROM
    movie_tbl AS movie
        LEFT JOIN
    rating_tbl AS rating ON movie.MId_PK = rating.MId_PK
GROUP BY movie.MId_PK
ORDER BY (MAX(rating.Stars_PK) - MIN(rating.Stars_PK)) DESC , movie.Title ASC;

/* Exercise 2: Find the difference between the average rating of movies 
   released before 1980 and the average rating of movies released after 
   1980. (Make sure to calculate the average rating for each movie, then 
   the average of those averages for movies before 1980 and movies after. 
   Don't just calculate the overall average rating before and after 1980.) 
   */
SELECT 
    ((SELECT 
            AVG(individualBeforeAvg)
        FROM
            (SELECT 
                AVG(rating.Stars_PK) AS individualBeforeAvg
            FROM
                movie_tbl AS movie
            LEFT JOIN rating_tbl AS rating ON movie.MId_PK = rating.MId_PK
            WHERE
                movie.YearMade < 1980
            GROUP BY movie.MId_PK) AS movieBeforeAvg) - (SELECT 
            AVG(individualAfterAvg)
        FROM
            (SELECT 
                AVG(rating.Stars_PK) AS individualAFterAvg
            FROM
                movie_tbl AS movie
            LEFT JOIN rating_tbl AS rating ON movie.MId_PK = rating.MId_PK
            WHERE
                movie.YearMade >= 1980
            GROUP BY movie.MId_PK) AS movieAfterAvg));

/* Exercise 3: Some directors directed more than one movie. For all 
   such directors, return the titles of all movies directed by them, 
   along with the director name. Sort by director name, then movie 
   title. (As an extra challenge, try writing the query both with and 
   without COUNT.) */
SELECT 
    Title, Director
FROM
    movie_tbl AS movie
WHERE
    Director IN (SELECT 
            Director
        FROM
            movie_tbl
        GROUP BY Director
        HAVING COUNT(Director) > 1)
ORDER BY Director , Title;
   
 /* Exercise 4: Find the movie(s) with the highest average rating. 
    Return the movie title(s) and average rating.  */  
SELECT 
    title, avgRating
FROM
    (SELECT 
        movie.Title AS title, AVG(rating.Stars_PK) AS avgRating
    FROM
        movie_tbl AS movie
    LEFT JOIN rating_tbl AS rating ON movie.MId_PK = rating.MId_PK
    GROUP BY movie.MId_PK) AS selectedTbl
HAVING avgRating = MAX(avgRating);

 /* Exercise 5: Find the movie(s) with the lowest average rating. 
    Return the movie title(s) and average rating.  */  
SELECT 
    title, avgRating
FROM
    (SELECT 
        movie.Title AS title, AVG(rating.Stars_PK) AS avgRating
    FROM
        movie_tbl AS movie
    LEFT JOIN rating_tbl AS rating ON movie.MId_PK = rating.MId_PK
    GROUP BY movie.MId_PK) AS selectedTbl
HAVING avgRating = MIN(avgRating);

/* Exercise 6: For each director, return the director's name together 
   with the title(s) of the movie(s) they directed that received the 
   highest rating among all of their movies, and the value of that rating.
   Ignore movies whose director is NULL.  */
SELECT 
    movie.Director, movie.Title, MAX(rating.Stars_PK)
FROM
    movie_tbl AS movie
        LEFT JOIN
    rating_tbl AS rating ON movie.MId_PK = rating.MId_PK
WHERE
    movie.Director IS NOT NULL
        AND rating.Stars_PK IS NOT NULL
GROUP BY movie.Director;

/* Exercise 7: For any rating where the reviewer is the same as the
   director of the movie, return the reviewer name, movie title, and 
   number of stars. */
SELECT 
    reviewer.Name, movie.title, rating.Stars_PK
FROM
    movie_tbl AS movie
        NATURAL JOIN
    rating_tbl AS rating
        NATURAL JOIN
    reviewer_tbl AS reviewer
WHERE
    movie.Director = reviewer.Name;

/* Exercise 8: Return all reviewer names and movie names together 
   in a single list, alphabetized. (Sorting by the first name of 
   the reviewer and first word in the title is fine; no need for 
   special processing on last names or removing "The".) */
SELECT 
    CONCAT(reviewer.Name, ' =||= ', movie.title)
FROM
    movie_tbl AS movie
        NATURAL JOIN
    rating_tbl AS rating
        NATURAL JOIN
    reviewer_tbl AS reviewer
ORDER BY reviewer.Name ASC , movie.title ASC;

/* Exercise 9: For all pairs of reviewers such that both reviewers 
   gave a rating to the same movie, return the names of both reviewers. 
   Eliminate duplicates, don't pair reviewers with themselves, and 
   include each pair only once. For each pair, return the names in 
   the pair in alphabetical order. */
SELECT DISTINCT
    rev1.Name, rev2.Name
FROM
    reviewer_tbl AS rev1
        INNER JOIN
    rating_tbl AS rat1 ON rat1.RId_PK = rev1.RId_PK,
    reviewer_tbl AS rev2
        INNER JOIN
    rating_tbl AS rat2 ON rat2.RId_PK = rev2.RId_PK
WHERE
    rev1.Name <> rev2.Name
        AND rat1.MId_PK = rat2.MId_PK
        AND rev1.Name < rev2.Name
ORDER BY rev1.Name;
    
    
   
   
/* Exercise 10: For each rating that is the lowest (fewest stars) 
   currently in the database, return the reviewer name, movie title,
   and number of stars. */
SELECT 
    reviewer.Name, movie.title, rating.Stars_PK
FROM
    movie_tbl AS movie
        NATURAL JOIN
    rating_tbl AS rating
        NATURAL JOIN
    reviewer_tbl AS reviewer
WHERE
    rating.Stars_PK IN (SELECT 
            MIN(Stars_PK)
        FROM
            rating_tbl);
   
   

      
      
      
      
      
      
      
      
      