/* Exercise 1: Write a trigger that makes new students named 'Friendly' 
   automatically like everyone else in their grade. That is, after the 
   trigger runs, we should have ('Friendly', A) in the Likes table for every 
   other Highschooler A in the same grade as 'Friendly'.*/
DELIMITER //
CREATE TRIGGER Friendly
AFTER INSERT ON highschooler_tbl
for each row
BEGIN 
    if new.name ='Friendly'
    then
    INSERT INTO likes_tbl SELECT new.Id_PK, h.Id_PK FROM highschooler_tbl as h
    WHERE new.grade = h.grade AND NOT (new.Id_PK=h.Id_PK);
    end if;
END ; //
DELIMITER ;

/* Exercise 2: Write one or more triggers to manage the grade attribute of 
   new Highschoolers. If the inserted tuple has a value less than 9 or 
   greater than 12, change the value to NULL. On the other hand, if the 
   inserted tuple has a null value for grade, change it to 9. To create 
   more than one trigger, separate the triggers with a vertical bar (|).*/
DELIMITER //
CREATE TRIGGER GradeCheck
BEFORE INSERT ON highschooler_tbl
for each row
BEGIN 
    if new.grade < 9 OR new.grade > 12
    then
    SET new.grade = null;
    elseif new.grade is null
    then
    SET new.grade = 9;
    end if;
END ; //
DELIMITER ;

/* Exercise 3: Write a trigger that automatically deletes students when 
   they graduate, i.e., when their grade is updated to exceed 12. */
DELIMITER //
CREATE TRIGGER Graduate
AFTER UPDATE ON highschooler_tbl
for each row
BEGIN 
    if new.grade > 12
    then
    DELETE FROM highschooler_tbl 
    WHERE Id_PK = new.Id_PK;
    end if;
END ; //
DELIMITER ;

/* Exercise 4: Write one or more triggers to maintain symmetry in friend 
   relationships. Specifically, if (A,B) is deleted from Friend, then (B,A) 
   should be deleted too. If (A,B) is inserted into Friend then (B,A) should 
   be inserted too. Don't worry about updates to the Friend table */
DELIMITER //
CREATE TRIGGER Symmetry
AFTER INSERT ON friend_tbl
for each row
BEGIN 
    if new.Id2_PK = Id1_PK XOR new.Id1_PK = Id2_PK
    then
	INSERT INTO friend_tbl SELECT h.Id_PK, new.Id_PK FROM friends_tbl as h
    WHERE new.Id1_PK = h.Id2_PK;
    end if;
END ; //
DELIMITER ;

/* Exercise 5: Write a trigger that automatically deletes students when 
   they graduate, i.e., when their grade is updated to exceed 12. In 
   addition, write a trigger so when a student is moved ahead one grade,
   then so are all of his or her friends. */
DELIMITER //
CREATE TRIGGER NextGrade
AFTER UPDATE ON highschooler_tbl
for each row
BEGIN 
    if new.grade > old.grade
    then
		if new.grade = grade
        then
			SET grade = grade+1;
		end if;
    end if;
END ; //
DELIMITER ;

/* Exercise 6: Write a trigger to enforce the following behavior: If A 
   liked B but is updated to A liking C instead, and B and C were friends, 
   make B and C no longer friends. Don't forget to delete the friendship in 
   both directions, and make sure the trigger only runs when the "liked" 
   (ID2) person is changed but the "liking" (ID1) person is not changed. */
DELIMITER //
CREATE TRIGGER NextGrade
AFTER UPDATE ON highschooler_tbl
for each row
BEGIN 
    if
    then
    end if;
END ; //
DELIMITER ;

