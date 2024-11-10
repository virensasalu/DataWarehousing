-- 1

CREATE DATABASE Customer;
SHOW DATABASES;

SHOW variables like "secure_file_priv";
USE Customer;
-- 2
CREATE TABLE Customer.CustomerChurn_Stage (
    CustomerId INT Primary key,
    Surname VARCHAR(255),
    CreditScore INT,
    Geography VARCHAR(100),
    Gender VARCHAR(10),
    Age INT,
    Balance DECIMAL(18, 2),
    Excited int
  
);



CREATE TABLE Customer.CustomerChurn (
    CustomerId INT Primary key,
    Surname VARCHAR(255),
    CreditScore INT,
    Geography VARCHAR(100),
    Gender VARCHAR(10),
    Age INT,
    Balance DECIMAL(18, 2), 
    SourceSystemNm NVARCHAR(20) NOT NULL , 
    CreateAgentId NVARCHAR(20) NOT NULL , 
    CreateDtm DATETIME NOT NULL, 
    ChangeAgentId NVARCHAR(20) NOT NULL ,
    ChangeDtm DATETIME NOT NULL 
  
);


-- 3

SELECT * FROM CustomerChurn_Stage;


SELECT 'Staging Table' AS Source, COUNT(*) AS Row_Count FROM Customer.CustomerChurn_Stage
UNION ALL
SELECT 'CSV File' AS Source, COUNT(*) AS Row_Count FROM CustomerChurn_Stage;

SELECT * FROM Customer.CustomerChurn_Stage
ORDER BY CustomerId DESC
LIMIT 10; 

-- 4
DELIMITER //

CREATE PROCEDURE Customer.PrCustomerChurn()
BEGIN

    DECLARE VarCurrentTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    DECLARE VarSourceRowCount, VarTargetRowCount, VarThresholdNbr INTEGER DEFAULT 0;
    DECLARE VarTinyIntVal TINYINT;

    SELECT COUNT(*) INTO VarSourceRowCount FROM Customer.CustomerChurn_Stage;

    SELECT COUNT(*) INTO VarTargetRowCount FROM Customer.CustomerChurn;

    SELECT CAST((VarTargetRowCount * .2) AS UNSIGNED INTEGER) INTO VarThresholdNbr;

    IF VarSourceRowCount < VarThresholdNbr THEN
        SELECT -129 INTO VarTinyIntVal;
    END IF;

   
    DELETE TrgtTbl
    FROM Customer.CustomerChurn AS TrgtTbl
    WHERE NOT EXISTS (
        SELECT *
        FROM Customer.CustomerChurn_Stage AS SrcTbl
        WHERE TrgtTbl.CustomerId = SrcTbl.CustomerId
    );

   
    UPDATE Customer.CustomerChurn AS TrgtTbl
    INNER JOIN Customer.CustomerChurn_Stage AS SrcTbl ON TrgtTbl.CustomerId = SrcTbl.CustomerId
    SET TrgtTbl.Surname = SrcTbl.Surname,
        TrgtTbl.CreditScore = SrcTbl.CreditScore,
        TrgtTbl.Geography = SrcTbl.Geography,
        TrgtTbl.Gender = SrcTbl.Gender,
        TrgtTbl.Age = SrcTbl.Age,
        TrgtTbl.Balance = SrcTbl.Balance,
        TrgtTbl.ChangeDtm = VarCurrentTimestamp
    WHERE TrgtTbl.Surname != SrcTbl.Surname
       OR TrgtTbl.CreditScore != SrcTbl.CreditScore
       OR TrgtTbl.Geography != SrcTbl.Geography
       OR TrgtTbl.Gender != SrcTbl.Gender
       OR TrgtTbl.Age != SrcTbl.Age
       OR TrgtTbl.Balance != SrcTbl.Balance;

  
    INSERT INTO Customer.CustomerChurn (
        CustomerId, Surname, CreditScore, Geography, Gender, Age, Balance,
        SourceSystemNm, CreateAgentId, CreateDtm, ChangeAgentId, ChangeDtm
    )
    SELECT 
        SrcTbl.CustomerId, SrcTbl.Surname, SrcTbl.CreditScore, SrcTbl.Geography, SrcTbl.Gender, SrcTbl.Age, SrcTbl.Balance,
        'Kaggle-CSV' AS SourceSystemNm,
        CURRENT_USER() AS CreateAgentId,
        VarCurrentTimestamp AS CreateDtm,
        CURRENT_USER() AS ChangeAgentId,
        VarCurrentTimestamp AS ChangeDtm
    FROM Customer.CustomerChurn_Stage AS SrcTbl
    LEFT JOIN Customer.CustomerChurn AS TrgtTbl ON SrcTbl.CustomerId = TrgtTbl.CustomerId
    WHERE TrgtTbl.CustomerId IS NULL;

END //

DELIMITER ;

-- 5


USE Customer;

CALL Customer.PrCustomerChurn();



SELECT 'Staging_Table_Row_Count' AS Source, COUNT(*) AS Row_Count
FROM Customer.CustomerChurn_Stage
UNION
SELECT 'Persistent_Table_Row_Count' AS Source, COUNT(*) AS Row_Count
FROM Customer.CustomerChurn;



SELECT * FROM Customer.CustomerChurn ORDER BY CustomerId DESC LIMIT 10;



-- 6


CREATE TABLE Customer.CustomerChurn_Version1 AS
SELECT * FROM Customer.CustomerChurn;

SELECT * FROM Customer.CustomerChurn_Version1;

SHOW CREATE TABLE Customer.CustomerChurn_Version1;
DESCRIBE Customer.CustomerChurn_Version1;

SELECT COUNT(*) AS Row_Count FROM Customer.CustomerChurn_Version1;




SELECT * FROM Customer.CustomerChurn_Version1 ORDER BY CustomerId DESC LIMIT 10;



TRUNCATE TABLE Customer.CustomerChurn_Stage;


-- 7


SELECT * FROM Customer.CustomerChurn_Stage;


SELECT * FROM Customer.CustomerChurn_Stage ORDER BY CustomerId DESC LIMIT 10;



SELECT 'CSV File' AS Source, COUNT(*) AS Row_Count
FROM CustomerChurn_Stage
UNION ALL
SELECT 'Staging Table' AS Source, COUNT(*) AS Row_Count
FROM Customer.CustomerChurn_Stage;

--  7

call Customer.PrCustomerChurn();


SELECT 'Customer.CustomerChurn_Version1' AS SOURCE, COUNT(*) AS Row_Count
FROM Customer.CustomerChurn_Version1
UNION
SELECT 'Customer.CustomerChurn' AS SOURCE, COUNT(*) AS Row_Count
FROM Customer.CustomerChurn;


SELECT * 
FROM Customer.CustomerChurn_Version1 v1
LEFT JOIN Customer.CustomerChurn c
ON v1.CustomerId = c.CustomerId
WHERE c.CustomerId IS NULL;






-- 8


SELECT *
FROM Customer.CustomerChurn AS Churn
INNER JOIN Customer.CustomerChurn_Version1 AS Version1
    ON Churn.CustomerId = Version1.CustomerId
WHERE NOT (
    Churn.Surname = Version1.Surname
    AND Churn.CreditScore = Version1.CreditScore
    AND Churn.Geography = Version1.Geography
    AND Churn.Gender = Version1.Gender
    AND Churn.Age = Version1.Age
    AND Churn.Balance = Version1.Balance
)
ORDER BY Churn.CustomerId;


-- 9

SELECT *
FROM Customer.CustomerChurn
WHERE CustomerId NOT IN (
    SELECT CustomerId
    FROM Customer.CustomerChurn_Version1
)
ORDER BY CustomerId;

























