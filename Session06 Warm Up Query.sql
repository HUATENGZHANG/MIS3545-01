use AdventureWorks2012;

/*1. Find out info of all the information customers */ 

select*
from sales.Customer;

/*2. Find out info of all the sales orders*/
select* /* * is wildcard */
from sales.SalesOrderHeader;

/*3. Find Sales info about productID 843*/
select * 
from sales.SalesOrderDetail
Where ProductID = 843;

/*4. Sales info of all the products of which unit price is between 10 0and 200*/
SELECT*
from sales.SalesOrderDetail
/* where UnitPrice between 100 and 200; */
where UnitPrice > 100 and UnitPrice < 200;

/* 5. Find out all the store names*/
SELECT Distinct Name 
from sales.Store;

/* 6. Find out store names that contain 'Bike'*/
SELECT Name
FROM sales.store 
where Name like '%Bikes' OR Name Like 'Bike%'; /* start with bike%, end with %bike, %bike% in the middle */

/*################### Grouo By PPT #####################*/

SELECT OnlineOrderFlag, COUNT(SalesOrderID) as Number, Avg(TotalDue)as Avg_Due, MAX(TotalDue)as max_due
From Sales.SalesOrderHeader
GROUP BY OnlineOrderFlag