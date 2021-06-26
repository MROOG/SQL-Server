use AdventureWorks2012

/*1.	Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema)
to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’*/
select H.SalesOrderID , H.ShipDate
from Sales.SalesOrderHeader H
where H.OrderDate between '7/28/2002' and '7/29/2014'


/*2.Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)*/
select P.ProductID , P.Name
from Production.Product P
where P.StandardCost < $110.00


/*3.	Display ProductID, Name if its weight is unknown*/
select P.ProductID , P.Name
from Production.Product P
where P.Weight is null

/*4.	 Display all Products with a Silver, Black, or Red Color*/
select*
from Production.Product P
where P.Color in ('Silver' , 'Black' ,'Red')


/*5. Display any Product with a Name starting with the letter B*/
select *
from Production.Product P
where P.Name like 'B%'

/*6.	Run the following Query
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3
Then write a query that displays any Product description with underscore value in its description.*/
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

-----------------------------
select PD.Description
from Production.ProductDescription PD
where PD.Description like '%_%'


/*7.	Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the
period between  '7/1/2001' and '7/31/2014'*/

select sum (SO.TotalDue) , SO.OrderDate
from Sales.SalesOrderHeader SO
where SO.OrderDate between '7/1/2001' and '7/31/2014'                            --there is no output !!!
group by SO.OrderDate


/*8.Display the Employees HireDate (note no repeated values are allowed)*/

select distinct HE.HireDate
from HumanResources.Employee HE

/*9.Calculate the average of the unique ListPrices in the Product table*/
select avg( distinct PP.ListPrice)
from Production.Product PP


/*10.Display the Product Name and its ListPrice within the values of 100 and 120 the list 
should has the following format "The [product name] is only! [List price]"
(the list will be sorted according to its ListPrice value)*/
select concat('The','   ', Name,'  ','is only !','    ' , PP.ListPrice) 
from Production.Product PP
where PP.ListPrice between 100 and 120



/*11.	

a)	 Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table  in a
newly created table named [store_Archive]
Note: Check your database to see the new table and how many rows in it?
b)	Try the previous query but without transferring the data? */


--insert into Archive1                                              --????
select SS.rowguid , SS.Name , SS.SalesPersonID ,SS.Demographics
into store_Archive
from Sales.Store SS



/*12.	Using union statement, retrieve the today’s date in different styles*/

select concat (25 ,'/',11,'/',2020)
union all
select convert (varchar(20) , getdate() , 102)
union all
select convert (varchar(20) , getdate() , 104)
union all
select convert (varchar(20) , getdate() , 105)
union all
select convert (varchar(20) , getdate() , 103)







/*Display results of the following two statements and explain what is the meaning of @@AnyExpression
select @@VERSION
select @@SERVERNAME*/
select @@VERSION
select @@SERVERNAME
