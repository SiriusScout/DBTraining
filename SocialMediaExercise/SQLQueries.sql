/* Exercise 1: Find all students who do not appear in the Likes table (as a 
   student who likes or is liked) and return their names and grades. 
   Sort by grade, then by name within each grade. */
SELECT 
    high.name, high.grade
FROM
    highschooler_tbl AS high
WHERE
    high.Id_PK NOT IN (SELECT 
            Id1_PK
        FROM
            likes_tbl)
        AND high.Id_PK NOT IN (SELECT 
            Id2_PK
        FROM
            likes_tbl)
ORDER BY high.grade, high.name;

/* Exercise 2: For each student A who likes a student B where the two 
   are not friends, find if they have a friend C in common (who can 
   introduce them!). For all such trios, return the name and grade 
   of A, B, and C. */
SELECT DISTINCT
    high1.name, high2.name, high3.name
FROM
    highschooler_tbl AS high1
        JOIN
    friend_tbl AS friend1 ON high1.Id_PK = friend1.Id1_PK,
    highschooler_tbl AS high2
        JOIN
    friend_tbl AS friend2 ON high2.Id_PK = friend2.Id1_PK,
    highschooler_tbl AS high3
        JOIN
    friend_tbl AS friend3 ON high3.Id_PK = friend3.Id1_PK,
    likes_tbl AS likes
WHERE
    (high1.Id_PK = friend2.Id1_PK
        OR high1.Id_PK = friend2.Id2_PK)
        AND (high2.Id_PK = friend3.Id1_PK
        OR high2.Id_PK = friend3.Id2_PK)
        AND (high1.Id_PK = likes.Id1_PK
        AND high3.Id_PK = likes.Id2_PK)
        AND (friend1.Id2_PK <> friend3.Id1_PK
        XOR friend1.Id2_PK = friend3.Id2_PK)
        AND (high1.Id_PK <> high2.Id_PK
        AND high2.Id_PK <> high3.Id_PK);	#names aren't equal to each other
        
/* Exercise 3: Find the difference between the number of students 
   in the school and the number of different first names. */
SELECT 
    COUNT(*) - COUNT(DISTINCT highschooler_tbl.name)
FROM
    highschooler_tbl;
    
/* Exercise 4: What is the average number of friends per student? 
   (Your result should be just one number.) */
SELECT 
    AVG(friendsCount)
FROM
    (SELECT 
        COUNT(*) AS friendsCount
    FROM
        friend_tbl
    GROUP BY friend_tbl.Id1_PK) AS newFriend;
    
/* Exercise 5: Find the number of students who are either friends 
   with Cassandra or are friends of friends of Cassandra. 
   Do not count Cassandra, even though technically she is 
   a friend of a friend. */
SELECT 
    COUNT(friendIN.Id2_PK)
FROM
    highschooler_tbl AS highIN
        JOIN
    friend_tbl AS friendIN ON highIN.Id_PK = friendIN.Id1_PK
WHERE
    highIN.Id_PK <> 'Cassandra'
        AND highIN.Id_PK = friendIN.Id1_PK
        AND highIN.Id_PK IN (SELECT 
            friendIN2.Id2_PK
        FROM
            highschooler_tbl AS highIN2
                JOIN
            friend_tbl AS friendIN2 ON highIN2.Id_PK = friendIN2.Id1_PK
        WHERE
            highIN2.name = 'Cassandra'
                AND highIN2.Id_PK = friendIN2.Id1_PK);
                
/* Exercise 6: Find the name and grade of the student(s) with 
   the greatest number of friends. */
SELECT 
    high.name, high.grade
FROM
    highschooler_tbl AS high
        JOIN
    friend_tbl AS friend ON high.Id_PK = friend.Id1_PK
GROUP BY friend.Id1_PK
HAVING COUNT(*) = (SELECT 
        MAX(maxCount)
    FROM
        (SELECT 
            COUNT(*) AS maxCount
        FROM
            friend_tbl
        GROUP BY friend_tbl.Id1_PK) AS countTable);


   
        
	
