CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `CreateAccount`(
	IN	ClientId INTEGER
)
BEGIN
	DECLARE AccountId INT;

	INSERT INTO `Account` (ClientId, DateOpened)
    VALUES (ClientId, CURDATE());
    
    SELECT LAST_INSERT_ID() INTO AccountId;
    INSERT INTO `HasAccount`
    VALUES (ClientId, AccountId);
    
    UPDATE `Client`
    SET `Client`.AccountNumber = `Client`.AccountNumber + 1
    WHERE Id = ClientId;
END