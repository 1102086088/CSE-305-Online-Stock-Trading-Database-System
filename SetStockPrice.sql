CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `SetStockPrice`(
	IN	StockSymbol     CHAR(20),
        PricePerShare   FLOAT
)
BEGIN
	UPDATE Stock
    SET Stock.PricePerShare = PricePerShare
    WHERE Stock.StockSymbol = StockSymbol;
END