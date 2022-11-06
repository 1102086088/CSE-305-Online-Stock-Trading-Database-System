CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `AddStock`(
	IN	StockSymbol		CHAR(20),
		CompanyName		CHAR(20),
		StockType		CHAR(20),
		PricePerShare	FLOAT,
		NumShares		INTEGER
)
BEGIN
	INSERT INTO `Stock`
    VALUES (StockSymbol, CompanyName, StockType, PricePerShare, NumShares);
END