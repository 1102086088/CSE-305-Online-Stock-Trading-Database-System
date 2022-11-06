CREATE DEFINER=`zhezhou1`@`%` PROCEDURE `ExecuteOrder`(
	IN	EmployeetId INTEGER,
		OrderId INTEGER
)
ProcExit:BEGIN
	DECLARE AccountId, NumShares, TransactionId, NumSharesStored, NumSharesHad INT;
    DECLARE SharePrice FLOAT;
    DECLARE StockId, OrderType CHAR(20);
    
    SELECT `Order`.StockSymbol INTO StockId FROM `Order` WHERE Id = OrderId;
    SELECT `Order`.OrderType INTO OrderType FROM `Order` WHERE Id = OrderId;
    SELECT `Order`.NumShares INTO NumShares FROM `Order` WHERE Id = OrderId;
    SELECT `Order`.AccountId INTO AccountId FROM `Order` WHERE Id = OrderId;
    SELECT PricePerShare INTO SharePrice FROM `Stock` WHERE StockSymbol = StockId;
    
    IF OrderType = 'Buy' THEN
		IF NOT EXISTS (SELECT * FROM `HasStock` WHERE `HasStock`.AccountId = AccountId) THEN
			INSERT INTO `HasStock`
            VALUES (AccountId, StockId, NumShares);
		ELSE
			UPDATE `HasStock`
            SET `HasStock`.NumShares = `HasStock`.NumShares + NumShares
            WHERE `HasStock`.AccountId = AccountId AND `HasStock`.StockSymbol = StockId;
		END IF;
        
        SELECT NumShares INTO NumSharesStored FROM `Stock`
        WHERE StockSymbol = StockId;
        If NumSharesStored >= NumShares THEN
			UPDATE `Stock`
			SET `Stock`.NumShares = `Stock`.NumShares - NumShares
			WHERE StockSymbol = StockId;
		ELSE
			LEAVE ProcExit;
		END IF;
	ELSE
		IF NOT EXISTS (SELECT * FROM `HasStock` WHERE `HasStock`.AccountId = AccountId) THEN
			LEAVE ProcExit;
		ELSE
			SELECT NumShares INTO NumSharesHad FROM `HasStock`
			WHERE `HasStock`.AccountId = AccountId AND `HasStock`.StockSymbol = StockId;
			IF NumSharesHad < NumShares THEN
				LEAVE ProcExit;
			ELSE
				UPDATE `HasStock`
				SET `HasStock`.NumShares = `HasStock`.NumShares - NumShares
				WHERE `HasStock`.AccountId = AccountId AND `HasStock`.StockSymbol = StockId;
                
                UPDATE `Stock`
				SET `Stock`.NumShares = `Stock`.NumShares + NumShares
				WHERE StockSymbol = StockId;
			END IF;
		END IF;
	END IF;
            
    UPDATE `Order` SET Executed = 'Yes' WHERE Id = OrderId;
    INSERT INTO `Transaction` (OrderId, Fee, DateTime, PricePerShare)
    VALUES (OrderId, 0.05 * NumShares * SharePrice, CURTIME(), SharePrice);
    
    SELECT MAX(Id) INTO TransactionId FROM `Transaction`;
    INSERT INTO `Trade` (AccountId, BrokerId, TransactionId, OrderId, StockId)
    VALUES (AccountId, EmployeetId, TransactionId, OrderId, StockId);
END