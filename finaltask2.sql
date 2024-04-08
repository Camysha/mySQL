DELIMITER //
drop procedure numbers;
CREATE PROCEDURE numbers()
BEGIN
    DECLARE n INT default 0;
    DECLARE m INT default 1;
    DROP TABLE IF EXISTS nums;
    CREATE TABLE nums (n INT);

    WHILE m < 1000 DO
    if (m % 15 = 0 or m % 33 = 0) then SET n = m;
    INSERT INTO nums VALUES(n);
    END if;
    set m = m+1;
    end WHILE; 

SELECT * FROM nums;
END //
DELIMITER ;

CALL numbers();