-- Entity Type
CREATE TABLE `Location` (
	ZipCode	INTEGER,
	City	CHAR(20) NOT NULL, 
    State	CHAR(20) NOT NULL,
	PRIMARY KEY (ZipCode)
);
CREATE TABLE `Person` (
	SSN			BIGINT,
	LastName	CHAR(20) NOT NULL, 
    FirstName	CHAR(20) NOT NULL,
    Address		CHAR(20),
	ZipCode		INTEGER,
    Telephone	BIGINT,
	PRIMARY KEY (SSN),
	FOREIGN KEY (ZipCode) REFERENCES `Location`(ZipCode)
		ON DELETE NO ACTION
        ON UPDATE CASCADE
);
CREATE TABLE `Employee` (
	ID			INTEGER NOT NULL AUTO_INCREMENT,
	SSN			BIGINT,
	StartDate	DATE,
	HourlyRate	INTEGER,
		CHECK (ID > 0 AND ID < 1000000000),
	PRIMARY KEY (ID),
	FOREIGN KEY (SSN) REFERENCES `Person`(SSN)
		ON DELETE NO ACTION 
        ON UPDATE CASCADE 
);
CREATE TABLE `Client` (
	Id					INTEGER NOT NULL AUTO_INCREMENT,
    SSN					BIGINT,
    Email 				CHAR(32),
    CreditCardNumber	BIGINT,
    Rating				INTEGER DEFAULT 1,
    AccountNumber		INTEGER DEFAULT 0,
		CHECK (Id > 0 AND Id < 1000000000),
    PRIMARY KEY (Id),
    FOREIGN KEY (SSN) REFERENCES `Person`(SSN)
        ON DELETE NO ACTION
        ON UPDATE CASCADE 
);

CREATE TABLE `Account` (
	Id			INTEGER NOT NULL AUTO_INCREMENT,
	ClientId	INTEGER,
    DateOpened	DATE,
    PRIMARY KEY (Id),
    FOREIGN KEY (ClientId) REFERENCES `Client`(Id)
        ON DELETE NO ACTION 
        ON UPDATE CASCADE 
);
CREATE TABLE `Order` (
	Id			INTEGER NOT NULL AUTO_INCREMENT,
    StockSymbol	CHAR(20) NOT NULL,
    OrderType	CHAR(20) NOT NULL CHECK (VALUE IN ('Buy', 'Sell')),
    NumShares	INTEGER,
	ClientId	INTEGER,
    AccountId	INTEGER,
    PriceType	CHAR(20) NOT NULL CHECK (VALUE IN ('Market', 'MarketOnClose', 'TrailingStop', 'HiddenStop')),
    Executed	CHAR(20) DEFAULT 'No' CHECK (VALUE IN ('Yes', 'No')),
    PRIMARY KEY (Id),
    FOREIGN KEY (AccountId) REFERENCES `Account`(Id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
);
CREATE TABLE `Transaction` ( 
    Id				INTEGER NOT NULL AUTO_INCREMENT,
    OrderId			INTEGER,
    Fee				FLOAT,
    DateTime		DATETIME, 
    PricePerShare	FLOAT,
    PRIMARY KEY (Id) 
);
CREATE TABLE `Stock` ( 
    StockSymbol		CHAR(20) NOT NULL,
    CompanyName		CHAR(20) NOT NULL,
    StockType		CHAR(20) NOT NULL,
    PricePerShare	FLOAT,
    NumShares		INTEGER,
    PRIMARY KEY (StockSymbol)
);

-- Relationship Type
CREATE TABLE `Trade` (
	AccountId 		INTEGER,
	BrokerId 		INTEGER,
    TransactionId   INTEGER,
	OrderId 		INTEGER,
	StockId 		CHAR(20),
	PRIMARY KEY (AccountId, BrokerId, TransactionId, OrderId, StockId), 
	FOREIGN KEY (AccountId) REFERENCES `Account`(Id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (BrokerId) REFERENCES `Employee`(ID)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (TransactionID) REFERENCES `Transaction`(Id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (OrderId) REFERENCES `Order`(Id)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (StockId) REFERENCES `Stock`(StockSymbol)
		ON DELETE NO ACTION
		ON UPDATE CASCADE 
);
CREATE TABLE `HasStock` (
	AccountId	  INTEGER,
    StockSymbol   CHAR(20) NOT NULL,
    NumShares     INTEGER,
    PRIMARY KEY (AccountId, StockSymbol),
    FOREIGN KEY (AccountId) REFERENCES `Account`(Id),
    FOREIGN KEY (StockSymbol) REFERENCES `Stock`(StockSymbol)
);
CREATE TABLE `HasAccount` (
	ClientId	INTEGER,
    AccountId	INTEGER,
    PRIMARY KEY (ClientId, AccountId),
    FOREIGN KEY (ClientId) REFERENCES `Client`(Id),
    FOREIGN KEY (AccountId) REFERENCES `Account`(Id)
);
    

