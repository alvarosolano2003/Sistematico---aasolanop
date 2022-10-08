use AdventureWorks2019
GO

CREATE PROCEDURE usp_ProductCategory
@Id INT,
@Name VARCHAR(50),
@myid uniqueidentifier,
@Modifieddate datetime
AS
	INSERT INTO Production.ProductCategory(ProductCategoryID, [Name], rowguid, ModifiedDate)
	VALUES(@Id, @Name, CONVERT(char(255), @myid) AS 'char', @Modifieddate)
GO

EXEC usp_ProductCategory 99, 'Celulares', NEWID(), '2021-12-12 02:00:40'
GO

CREATE FUNCTION f_BirthDates()
RETURNS @BirthDayTable TABLE(
		LoginId INT,
		JobTitle NVARCHAR(50),
		BirthDate DATE,
		HireDate DATE,
		Edad INT,
		Antiguedad INT
	)
AS
BEGIN
	INSERT INTO @BirthDayTable(LoginId, JobTitle, BirthDate, HireDate)
	SELECT t.[LoginID] AS LoginID, t.[JobTitle] AS JobTitle, t.[BirthDate] AS BirthDate, t.[HireDate] AS HireDate
	FROM HumanResources.Employee t

	INSERT INTO @BirthDayTable(Edad, Antiguedad)
	SELECT (YEAR(GETDATE()) - YEAR(t.BirthDate)) AS EDAD, (YEAR(GETDATE()) - YEAR(t.HireDate))
	FROM HumanResources.Employee t

	RETURN;
END
GO

SELECT * FROM f_BirthDates()
GO
