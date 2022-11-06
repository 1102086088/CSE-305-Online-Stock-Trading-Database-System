CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `ListOrdersByStockSymbol`(
	IN StockSymbol CHAR(20)
)
BEGIN
	SELECT Id, StockSymbol, OrderType, NumShares, ClientId, AccountId, PriceType, Executed
    FROM `Order`
	WHERE `Order`.StockSymbol = StockSymbol;
END