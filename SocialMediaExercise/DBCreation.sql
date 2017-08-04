CREATE DATABASE SocialMediaDB;
USE SocialMediaDB;

#table creation
CREATE TABLE highschooler_tbl (
    Id_PK INT NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    grade INT
);
    
CREATE TABLE friend_tbl (
    Id1_PK INT NOT NULL,
    Id2_PK INT NOT NULL,
    PRIMARY KEY (Id1_PK , Id2_PK),
    FOREIGN KEY (Id1_PK)
        REFERENCES highschooler_tbl (Id_PK) ON DELETE CASCADE,
    FOREIGN KEY (Id2_PK)
        REFERENCES highschooler_tbl (Id_PK) ON DELETE CASCADE
);

CREATE TABLE likes_tbl (
    Id1_PK INT NOT NULL,
    Id2_PK INT NOT NULL,
    PRIMARY KEY (Id1_PK , Id2_PK),
    FOREIGN KEY (Id1_PK)
        REFERENCES highschooler_tbl (Id_PK) ON DELETE CASCADE,
    FOREIGN KEY (Id2_PK)
        REFERENCES highschooler_tbl (Id_PK) ON DELETE CASCADE
);

SELECT * FROM friend_tbl;
SELECT * FROM Likes_tbl;

#adding records
#adding highschoolers
#Freshmen
INSERT INTO highschooler_tbl VALUES(1, 'Jordan', 9);
INSERT INTO highschooler_tbl VALUES(2, 'Gabriel', 9);
INSERT INTO highschooler_tbl VALUES(3, 'Tiffany', 9);
INSERT INTO highschooler_tbl VALUES(4, 'Cassandra', 9);
#Sophomores
INSERT INTO highschooler_tbl VALUES(5, 'Kris', 10);
INSERT INTO highschooler_tbl VALUES(6, 'Haley', 10);
INSERT INTO highschooler_tbl VALUES(7, 'Andrew', 10);
INSERT INTO highschooler_tbl VALUES(8, 'Brittany', 10);
#Junior
INSERT INTO highschooler_tbl VALUES(9, 'Alexis', 11);
INSERT INTO highschooler_tbl VALUES(10, 'Austin', 11);
INSERT INTO highschooler_tbl VALUES(11, 'Gabriel', 11);
INSERT INTO highschooler_tbl VALUES(12, 'Jessica', 11);
#Senior
INSERT INTO highschooler_tbl VALUES(13, 'Jordan', 12);
INSERT INTO highschooler_tbl VALUES(14, 'John', 12);
INSERT INTO highschooler_tbl VALUES(15, 'Kyle', 12);
INSERT INTO highschooler_tbl VALUES(16, 'Logan', 12);

#Friends
INSERT INTO friend_tbl VALUES(1, 2);
INSERT INTO friend_tbl VALUES(2, 1);

INSERT INTO friend_tbl VALUES(1, 3);
INSERT INTO friend_tbl VALUES(3, 1);

INSERT INTO friend_tbl VALUES(4, 2);
INSERT INTO friend_tbl VALUES(2, 4);

INSERT INTO friend_tbl VALUES(7, 2);
INSERT INTO friend_tbl VALUES(2, 7);

INSERT INTO friend_tbl VALUES(5, 7);
INSERT INTO friend_tbl VALUES(7, 5);

INSERT INTO friend_tbl VALUES(5, 6);
INSERT INTO friend_tbl VALUES(6, 5);

INSERT INTO friend_tbl VALUES(5, 8);
INSERT INTO friend_tbl VALUES(8, 5);

INSERT INTO friend_tbl VALUES(6, 8);
INSERT INTO friend_tbl VALUES(8, 6);

INSERT INTO friend_tbl VALUES(3, 9);
INSERT INTO friend_tbl VALUES(9, 3);

INSERT INTO friend_tbl VALUES(4, 9);
INSERT INTO friend_tbl VALUES(9, 4);

INSERT INTO friend_tbl VALUES(9, 11);
INSERT INTO friend_tbl VALUES(11, 9);

INSERT INTO friend_tbl VALUES(9, 12);
INSERT INTO friend_tbl VALUES(12, 9);

INSERT INTO friend_tbl VALUES(11, 12);
INSERT INTO friend_tbl VALUES(12, 11);

INSERT INTO friend_tbl VALUES(7, 10);
INSERT INTO friend_tbl VALUES(10, 7);

INSERT INTO friend_tbl VALUES(10, 15);
INSERT INTO friend_tbl VALUES(15, 10);

INSERT INTO friend_tbl VALUES(13, 15);
INSERT INTO friend_tbl VALUES(15, 13);

INSERT INTO friend_tbl VALUES(13, 16);
INSERT INTO friend_tbl VALUES(16, 13);

INSERT INTO friend_tbl VALUES(14, 16);
INSERT INTO friend_tbl VALUES(16, 14);

INSERT INTO friend_tbl VALUES(12, 15);
INSERT INTO friend_tbl VALUES(15, 12);

INSERT INTO friend_tbl VALUES(7, 13);
INSERT INTO friend_tbl VALUES(13, 7);

#likes
INSERT INTO likes_tbl VALUES(4, 2);
INSERT INTO likes_tbl VALUES(2, 4);
INSERT INTO likes_tbl VALUES(9, 5);
INSERT INTO likes_tbl VALUES(11, 9);
INSERT INTO likes_tbl VALUES(7, 4);
INSERT INTO likes_tbl VALUES(8, 5);
INSERT INTO likes_tbl VALUES(14, 6);
INSERT INTO likes_tbl VALUES(10, 13);
INSERT INTO likes_tbl VALUES(12, 15);
INSERT INTO likes_tbl VALUES(15, 12);