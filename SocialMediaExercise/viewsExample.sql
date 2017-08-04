use socialmediadb;
SELECT * FROM highschooler_tbl;

CREATE VIEW name_view AS 
SELECT DISTINCT
        high1.name AS name1,
        high2.name AS name2,
        high3.name AS name3,
        high1.Id_PK AS highID1,
        high2.Id_PK AS highID2,
        high3.Id_PK AS highID3,
        friend1.Id1_PK AS friend1ID1,
        friend1.Id2_PK AS friend1ID2,
		friend2.Id1_PK AS friend2ID1,
        friend2.Id2_PK AS friend2ID2,
        friend3.Id1_PK AS friend3ID1,
        friend3.Id2_PK AS friend3ID2,
		likes.Id1_PK AS likesID1,
        likes.Id2_PK AS likesID2
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
		high1.name <> high2.name AND high2.name <> high3.name AND high1.name <> high3.name;

DROP VIEW name_view;

SELECT * FROM name_view;

SELECT DISTINCT
	name1,
	name2,
	name3
FROM
	name_view
WHERE
	(highID1 = friend2ID1
		OR highID1 = friend2ID2)
		AND (highID2 = friend3ID1
		OR highID2 = friend3ID2)
		AND (highID1 = likesID1
		AND highID3 = likesID2)
		AND (friend1ID2 <> friend3ID1
		XOR friend1ID2 = friend3ID2)
		AND (highID1 <> highID2
		AND highID2 <> highID3);
