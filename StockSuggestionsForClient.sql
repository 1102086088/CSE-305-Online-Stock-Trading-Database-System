CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `StockSuggestionsForClient` (
	IN	ClientId BIGINT
)
BEGIN
	SELECT * FROM `Stock`
    WHERE 
		StockSymbol IN (
			SELECT DISTINCT(StockSymbol) FROM `Order`
			WHERE `Order`.ClientId = ClientId
		);
END