-- Truncate all tables... can't be too hard, can it? Naturally, there
-- is no "TRUNCATE ALL TABLES" command, that would be much too
-- easy. OK, let's google for it. Hmm. A lot of solutions but nothing
-- seems to do it all in SQL. That's silly. It can't be impossible,
-- right? OK, first it looks like we need a list of all the table
-- names, and then we can PREPARE a bunch of truncate statements
-- against that. Sounds simple enough. Wait, we can't put rows into
-- some sort of array variable? Hmm. Ok, it looks like this is what
-- cursors are for. Err... let's copy and paste this weird code to
-- step a cursor through a result set. Alright, now we've got our
-- array of table names, and let's turn these into TRUNCATE
-- statements. Hmm. Mysql keeps giving me a parse error with no
-- indication of what the problem is. Alright, google around... arrg,
-- cursors can't be used with user defined variables. OK, we will have
-- to SET a char value? Yeah, that seems to work. Now let's PREPARE a
-- statement from that and execute it. Umm... more parse errors, and
-- it's not telling me what's going on. OK, more
-- googling. Uhh... PREPARE statements can't be used with that kind of
-- variable? Wait a second, can they be used with cursors at all?
-- Let's google... Motherfucker. No, they can't. OK, back to the
-- drawing board. How the hell do I execute a bunch of statements
-- built up from a SELECT query result? Uhh.... yeah. Save it all as
-- one big strings, delineated by commas, and then successively step
-- through it with SUBSTRING calls. Christ.

CREATE PROCEDURE truncateall()
BEGIN
  SET @myArrayOfValue = null ;
  SELECT GROUP_CONCAT('TRUNCATE TABLE ', TABLE_NAME, ';')
    FROM INFORMATION_SCHEMA.TABLES
    WHERE table_schema = (SELECT DATABASE()) INTO @myArrayOfValue;

  WHILE (LOCATE(',', @myArrayOfValue) > 0)
  DO
    SET @value = SUBSTRING(@myArrayOfValue, 1, LOCATE(',', @myArrayOfValue) - 1);
    SET @myArrayOfValue = SUBSTRING(@myArrayOfValue, LOCATE(',', @myArrayOfValue) + 1);

    IF (LENGTH(@value) > 0)
    THEN
      PREPARE stmt FROM @value;
      EXECUTE stmt;
      DEALLOCATE PREPARE stmt;
    END IF;
  END WHILE;
END;

SET FOREIGN_KEY_CHECKS = 0;
SET GROUP_CONCAT_MAX_LEN=32768;
CALL truncateall() ;
SET FOREIGN_KEY_CHECKS = 1;
