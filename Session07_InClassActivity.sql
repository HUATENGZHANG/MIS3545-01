/*1, Display the total amount (sum) collected from the orders for each order date (group by). */
SELECT OrderDate, SUM(TotalDue) as Daily_Amount, 
Count(SalesOrderID) AS Number_of_Orders /* use unique rows*/
From Sales.SalesOrderHeader
Group By OrderDate
Order BY sum(TotalDue) DESC;


/*2, Display the total amount collected from selling the products (RELATE TO PRODUCT, so use detail table), 774 and 777. */
SELECT SUM(LineTotal) AS Total_Amount, ProductID, Sum(OrderQty) as Total_Number_of_Units_Sold,
AVG(UnitPrice) as Avg_Unit_Price,
MAX(UnitPrice) as Max_Unit_Price,
Min(UnitPrice) as Min_Unit_Price
FROM Sales.SalesOrderDetail
Where ProductID = 774 OR ProductID = 777 /* not and because there is no one has both numbers*/
/*Where ProducID Between 700 and 800*/
Group by ProductID   /*having and where has same function, having goes after group by*/ 
Having sum(OrderQty) > 3000 /* Having cannot go after order by*/
Order by sum(OrderQty) DESC;

/*Professor's Solution*/
/*2, Display the total amount collected from selling the products, FROM 700 to 800. Only list those products that have been sold more than 3000 units.*/
SELECT ProductID, SUM(LineTotal) as Total_Amount,
AVG(UnitPrice) as Avg_Unit_Price,
MAX(UnitPrice) as Max_Unit_Price,
Min(UnitPrice) as Min_Unit_Price,
SUM(OrderQty) as 'Total Number of Units Sold'
FROM Sales.SalesOrderDetail
WHERE ProductID Between 700 and 800
GROUP BY ProductID
HAVING SUM(OrderQty)>3000
ORDER BY SUM(OrderQty) DESC;


/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons 
and the name of the territory to which they belong.*/
SELECT ssp.BusinessEntityID, pp.FirstName as first_name, pp.LastName as last_name, sst.Name as Territory_Name
FROM SALES.SalesPerson as ssp
Full Outer JOIN Sales.SalesTerritory as sst 
/* with full outer join, we get all the sales people even though they don't belong to any territory*/
ON ssp.TerritoryID=sst.TerritoryID
JOIN Person.Person as pp
ON pp.BusinessEntityID=ssp.BusinessEntityID; 


/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
SELECT p.BusinessEntityID, p.FirstName, p.LastName, c.CardType as Card_Type
FROM Person.Person as p
JOIN Sales.PersonCreditCard as pc 
ON p.BusinessEntityID = pc.BusinessEntityID
JOIN Sales.CreditCard as c
ON pc.CreditCardID= c.CreditCardID
Where c.CardType = 'Vista' /* use single qoute*/


/*Show the number of customers for each type of credit cards*/
SELECT c.CardType, count(sc.CustomerID) as Number_of_Customer /* need to specify table for every column*/
FROM Sales.CreditCard as c
JOIN Sales.SalesOrderHeader as oh
ON oh.CreditCardID=c.CreditCardID
JOIN Sales.Customer as sc
ON oh.CustomerID=sc.CustomerID
Group By c.CardType
/* Key is to FIND CREDIT CARD ID AND Customer ID both in Sales.OrderHeader*/

/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory*/
SELECT t.TerritoryID, r.CountryRegionCode,r.Name as Country,t.Name as Territory 
FROM Sales.SalesTerritory as t
Full Outer Join Person.CountryRegion as r
ON t.CountryRegionCode=r.CountryRegionCode
Where t.TerritoryID = null; /* List all the countries/regions that do not have Territory ID, We set Null when we know there is no */


/*6, Find out the average of the total dues of all the orders.*/
SELECT Avg(TotalDue) as Avg_Total_Due
From Sales.SalesOrderHeader;

/* Professor's Solution: :6, Find out the average of the total dues of all the orders.*/
SELECT AVG(TotalDue)
FROM Sales.SalesOrderHeader;

/*7, Write a query to report the sales order ID of those orders where 
the total due is greater than the average of the total dues of all the orders*/
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 
      (
		SELECT AVG(TotalDue)
		FROM Sales.SalesOrderHeader
	  )
ORDER BY TotalDue; /*当大于一个aggregate的时候，要注意格式*/


/*Professor's Version*/
/*1, Display the total amount collected from the orders for each order date. */
SELECT OrderDate, SUM(TotalDue) as Daily_Amount,
COUNT(SalesOrderID) as Number_of_Orders
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
ORDER BY SUM(TotalDue) DESC;

/*2, Display the total amount collected from selling the products, FROM 700 to 800. Only list those products that have been sold more than 3000 units.*/
SELECT ProductID, SUM(LineTotal) as Total_Amount,
AVG(UnitPrice) as Avg_Unit_Price,
MAX(UnitPrice) as Max_Unit_Price,
Min(UnitPrice) as Min_Unit_Price,
SUM(OrderQty) as 'Total Number of Units Sold'
FROM Sales.SalesOrderDetail
WHERE ProductID Between 700 and 800
GROUP BY ProductID
HAVING SUM(OrderQty)>3000
ORDER BY SUM(OrderQty) DESC;


/*3, Write a query to display the sales person BusinessEntityID, last name and first name of ALL the sales persons and the name of the territory to which they belong, even though they don't belong to any territory.*/
SELECT SP.BusinessEntityID, 
		P.FirstName, 
		P.LastName, 
		ST.Name as Territory
FROM Sales.SalesPerson as SP
FULL OUTER JOIN Sales.SalesTerritory as ST
On SP.TerritoryID = ST.TerritoryID
JOIN Person.Person as P
ON SP.BusinessEntityID = P.BusinessEntityID;

/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory*/
SELECT cr.Countryregioncode, 
	cr.Name AS Country, 
	st.TerritoryID, 
	st.name AS Territory
FROM Sales.SalesTerritory AS st
RIGHT OUTER JOIN Person.CountryRegion AS cr 
ON cr.countryregioncode = st.CountryRegionCode
WHERE st.TerritoryID is null; /*list all the countries/regions that do not belong to any territory*/

/*6, Find out the average of the total dues of all the orders.*/
SELECT AVG(TotalDue)
FROM Sales.SalesOrderHeader;



/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 
      (
		SELECT AVG(TotalDue)
		FROM Sales.SalesOrderHeader
	  )
ORDER BY TotalDue;