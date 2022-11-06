CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `RecordOrder`(
	IN	StockSymbol	CHAR(20),
		OrderType	CHAR(20),
		NumShares	INTEGER,
		ClientId	INTEGER,
		AccountId	INTEGER,
		PriceType	CHAR(20)
)
BEGIN
	INSERT INTO `Order` (StockSymbol, OrderType, NumShares, ClientId, AccountId, PriceType)
    VALUES (StockSymbol, OrderType, NumShares, ClientId, AccountId, PriceType);
END