CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `AddEmployee`(
	IN	SSN				 BIGINT,
		LastName 		 CHAR(20),
        FirstName 		 CHAR(20),
        Address 		 CHAR(20),
        City			 CHAR(20),
		State		     CHAR(20),
		ZipCode     	 INTEGER,
		Telephone   	 BIGINT,
        HourlyRate	INTEGER
)
BEGIN
	IF 
		NOT EXISTS(SELECT * FROM `Location` WHERE Location.ZipCode = ZipCode)
    THEN 
		INSERT INTO `Location`
        VALUES (ZipCode, City, State);
	END IF;
    
    INSERT INTO `Person`
    VALUES (SSN, LastName, FirstName, Address, ZipCode, Telephone);
		
	INSERT INTO `Employee` (SSN, StartDate, HourlyRate)
    VALUES (SSN, CURDATE(), HourlyRate);
END