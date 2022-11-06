CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `ClientStockHoldings`(
	IN	ClientId INTEGER
)
BEGIN
	SELECT StockSymbol, NumShares
    FROM `Account`, `HasStock`
    WHERE Id = AccountId AND `Account`.ClientId = ClientId;
END