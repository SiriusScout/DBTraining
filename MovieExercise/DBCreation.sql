CREATE DATABASE Movies_DB;
USE Movies_DB;

/*Creating the movie table*/
CREATE TABLE movie_tbl (
    MId_PK INT NOT NULL PRIMARY KEY,
    Title VARCHAR(255),
    Year INT,
    Director VARCHAR(255)
);
                
/*Creating the reviewer table*/
CREATE TABLE reviewer_tbl (
    RId_PK INT NOT NULL PRIMARY KEY,
    Name VARCHAR(255)
);

/*Creating the rating table*/
CREATE TABLE rating_tbl (
    RId_PK INT NOT NULL,
    MId_PK INT NOT NULL,
    Stars_PK INT,
    RatingDate DATE,
    PRIMARY KEY (RId_PK , MId_PK , Stars_PK),
    FOREIGN KEY (RId_PK)
        REFERENCES reviewer_tbl (RId_PK),
    FOREIGN KEY (MId_PK)
        REFERENCES movie_tbl (MId_PK)
);  

/*Table Descriptions*/
DESCRIBE movie_tbl;
DESCRIBE reviewer_tbl;
DESCRIBE rating_tbl;              

/*Insert statements*/
/*Movies*/
insert into movie_tbl values(101, 'Gone with the Wind', 1939, 'Victor Fleming');
insert into movie_tbl values(102, 'Star Wars', 1977, 'George Lucas');
insert into movie_tbl values(103, 'The Sound of Music', 1965, 'Robert Wise');
insert into movie_tbl values(104, 'E.T.', 1982, 'Steven Spielberg');
insert into movie_tbl values(105, 'Titanic', 1997, 'James Cameron');
insert into movie_tbl values(106, 'Snow White', 1937, null);
insert into movie_tbl values(107, 'Avatar', 2009, 'James Cameron');
insert into movie_tbl values(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

/*Reviewers*/
insert into reviewer_tbl values(201, 'Sarah Martinez');
insert into reviewer_tbl values(202, 'Daniel Lewis');
insert into reviewer_tbl values(203, 'Brittany Harris');
insert into reviewer_tbl values(204, 'Mike Anderson');
insert into reviewer_tbl values(205, 'Chris Jackson');
insert into reviewer_tbl values(206, 'Elizabeth Thomas');
insert into reviewer_tbl values(207, 'James Cameron');
insert into reviewer_tbl values(208, 'Ashley White');

/*Ratings*/
insert into rating_tbl values(201, 101, 2, '2011-01-22');
insert into rating_tbl values(201, 101, 4, '2011-01-27');
insert into rating_tbl values(202, 106, 4, null);
insert into rating_tbl values(203, 103, 2, '2011-01-20');
insert into rating_tbl values(203, 108, 4, '2011-01-12');
insert into rating_tbl values(203, 108, 2, '2011-01-30');
insert into rating_tbl values(204, 101, 3, '2011-01-09');
insert into rating_tbl values(205, 103, 3, '2011-01-27');
insert into rating_tbl values(205, 104, 2, '2011-01-22');
insert into rating_tbl values(205, 108, 4, null);
insert into rating_tbl values(206, 107, 3, '2011-01-15');
insert into rating_tbl values(206, 106, 5, '2011-01-19');
insert into rating_tbl values(207, 107, 5, '2011-01-20');
insert into rating_tbl values(208, 104, 3, '2011-01-02');