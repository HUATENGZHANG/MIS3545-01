/* Using the HumanResource.Employee table, provide a count of the number of employees by job title.  
The query should consider only current employees (the CurrentFlag must equal 1)*/
                                            
Select [JobTitle], COUNT (BusinessEntityID) As Number_of_Employees 
From HumanResources.Employee
WHERE CurrentFlag=1
Group by JobTitle

/* as is for rename 
having is only used when group by is used*/

/* PPT EXAMPLE8*/

Select TerritoryID, 
OrderDate, COUNT(SalesOrderID) as Number_of_Orders, Sum(TotalDue) as Amount_Due
From Sales.SalesOrderHeader
Where OrderDate < '2007-01-01'
Group by TerritoryID, OrderDate
Having OrderDate>'2006-01-01'; /* Having Sum(TotalDue) > 5000 */

/* Activity2 Modify the query you created in Activity 1 so that the output shows only those job titles 
for which there is more than 1 employee.*/

Select [JobTitle], COUNT (BusinessEntityID) As Number_of_Employees 
From HumanResources.Employee
WHERE CurrentFlag=1
Group by JobTitle
Having COUNT(BusinessEntityID) > 1 /* can not use number_of_employees as the original table does not contain*/
ORDER BY COUNT(BusinessEntityID) DESC

/* Grammar for JOIN From Item 1 INNER JOIN Item2 ON Condition */

/* Example Using Inner Join With Inner Join Key Words*/
SELECT s.[SalesOrderID]
      ,s.[SalesOrderDetailID]
	  ,s.[OrderQty]
	  ,s.[ProductID]
	  ,p.[Name]
FROM Sales.SalesOrderDetail AS s INNER JOIN Production.Product AS p
ON s.[ProductID] = p.ProductID

/* Example Using Inner Join Without Inner Join Key Words, WHERE*/
SELECT s.[SalesOrderID]
      ,s.[SalesOrderDetailID]
	  ,s.[OrderQty]
	  ,s.[ProductID]
	  ,p.[Name]
	  FROM Sales.SalesOrderDetail AS s,Production.Product AS p
	  WHERE s.ProductID=p.ProductID


/* Sequential Join*/
SELECT S.NAME AS Store, PA.City, SP.Name AS State, 
       CR.Name AS CountryRegion
FROM Sales.Store AS S 
JOIN Person.BusinessEntityAddress AS A ON
     A.BusinessEntityID = S.BusinessEntityID
JOIN Person.Address AS PA ON 
     A.AddressID = PA.AddressID
JOIN Person.StateProvince SP ON
     SP.StateProvinceID = PA.StateProvinceID
JOIN Person.CountryRegion CR ON 
     CR.CountryRegionCode = SP.CountryRegionCode
ORDER BY S.name 

/* ACTIVITY 3 For each product, show its ProductID and Name (from the ProductionProduct table) and 
the location of its inventory (from the Product.Location table) and amount of inventory 
held at that location (from the Production.ProductInventory table). */

SELECT PP.Name As Product_Name, PP.ProductID,
       PL.Name AS Location,
	   PPI.Quantity AS Inventory_Qty
FROM Production.Product AS PP
JOIN Production.ProductInventory AS PPI ON
PP.ProductID=PPI.ProductID
JOIN Production.Location AS PL ON
PPI.LocationID=PL.LocationID
ORDER BY PL.Name

/* Professor's Solution*/


/*3. For each product, show its ProductID and Name (from the ProductionProduct table) and the location of its inventory (from the Product.Location table) and amount of inventory held at that location (from the Production.ProductInventory table).*/

SELECT pp.ProductID, pp.Name AS Product_Name,  PL.Name AS Location, i.Quantity
FROM Production.Product AS  pp
JOIN  Production.ProductInventory AS i
ON pp.ProductID = i.ProductID
JOIN Production.Location AS PL
On PL.LocationID = I.LocationID;


/* left right outter JOIN */
SELECT SalesOrderID
,s.SalesOrderDetailID
,p.ProductID
,p.Name
FROM Sales.SalesOrderDetail AS s
RIGHT OUTER JOIN Production.Product AS p
ON s.ProductID=p.ProductID

/*ACTIVITY 4*/
/*Find the product model IDs that have no product associated with them.  
To do this, first do an outer join between the Production.Product table
 and the Production.ProductModel table in such a way that the ID from the 
 ProductModel table always shows, even if there is no product associate with it.  
Then, add a WHERE clause to specify that the ProductID IS NULL */

SELECT ppm.ProductModelID
,pp.ProductID  
,ppm.Name AS Model_Name    
,pp.Name AS Product_Name    
FROM Production.Product AS pp     
FULL OUTER JOIN Production.ProductModel AS ppm    
ON pp.Name=ppm.Name    
WHERE ProductID IS NULL   

/* Professor's Solution*/

/*4. Find the product model IDs that have no product associated with them. 
	To do this, first do an outer join between the Production.Product table and the Production.ProductModel table in such a way that the ID from the ProductModel table always shows, even if there is no product associate with it.  
	Then, add a WHERE clause to specify that the ProductID IS NULL */
SELECT m.ProductModelID, m.Name AS model_name,  p.ProductID,  p.Name AS product_name
FROM Production.ProductModel AS m
left outer join Production.Product AS p
ON p.ProductModelID=m.ProductModelID
WHERE p.ProductID is null;


/*for comparison, below is inner join*/ 
Select m.ProductModelID, m.Name as model_name,  p.ProductID,  p.Name as product_name
From Production.Product as p
join Production.ProductModel as m
on p.ProductModelID=m.ProductModelID
where p.ProductID is null; /* nothing appears as there is no column that both tables contain,
therefore there will be no table could be connected */

/*for comparison, below is full outer join*/ 
Select m.ProductModelID, m.Name as model_name,  p.ProductID,  p.Name as product_name
From Production.Product as p
full outer join Production.ProductModel as m
on p.ProductModelID=m.ProductModelID
where m.ProductModelID is null


