CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `ListAllClientMailings`()
BEGIN
	SELECT Id, LastName, FirstName, Email, Address, City, State, `Location`.ZipCode AS ZipCode
    FROM `Client`, `Person`, `Location`
    WHERE `Client`.SSN = `Person`.SSN AND `Person`.ZipCode = `Location`.ZipCode;
END