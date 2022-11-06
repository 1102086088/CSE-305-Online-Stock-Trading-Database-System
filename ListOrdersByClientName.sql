CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `ListOrdersByClientName`(
	IN	ClientLastName	CHAR(20),
		ClientFirstName CHAR(20)
)
BEGIN
    SELECT Id, StockSymbol, OrderType, NumShares, ClientId, AccountId, PriceType, Executed
    FROM `Order`
    WHERE 
        AccountId IN (
			SELECT `Account`.Id FROM `Person`, `Client`, `Account`
			WHERE 
				`Person`.SSN = `Client`.SSN AND 
                `Client`.Id = `Account`.ClientId AND
                (ClientLastName = LastName AND ClientFirstName = FirstName)
		);
END