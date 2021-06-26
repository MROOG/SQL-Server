use [SD32-Company]
/*
2.	Create the following schema and transfer the following tables to it 
a.	Company Schema 
i.	Department table (Programmatically)
ii.	Project table (visually)
b.	Human Resource Schema
i.	  Employee table (Programmatically)
*/
create schema Company
create schema Human_Resource

alter schema Company transfer Department 

alter schema Human_Resource transfer Employee


/*3 Write query to display the constraints for the Employee table.  */

select* from	INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where TABLE_NAME = 'Employee'



/*4.Create Synonym for table Employee as Emp and then run the following queries and describe the results
a.	Select * from Employee
b.	Select * from [Human Resource].Employee
c.	Select * from Emp
d.	Select * from [Human Resource].Emp*/

create synonym Emp
for Human_Resource.Employee


select*from Employee                --invalid
Select * from [Human_Resource].Employee
Select * from Emp                                   --invalid but why??
Select * from [Human Resource].Emp                    ---??


/*5 Increase the budget of the project where the manager number is 10102 by 10%.*/

update Project 
  set Budget = 1.1*Budget
from Project P , Works_on W , [Human_Resource].Employee E
where P.ProjectNo =W.ProjectNo and W.EmpNo = E.EmpNo and E.EmpNo = 10102



/*6.Change the name of the department for which the employee named James works.The new department name is Sales .*/

update D
 set D.DeptName = 'Sales'
from [Human_Resource].Employee E , Company.Department D
where D.DeptNo = E.DeptNo and E.EmpFname = 'James'


/*7.Change the enter date for the projects for those employees who 
work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.*/
update W
set W.Enter_Date = '12.12.2007'
from Works_on W , Project P , Company.Department D , [Human_Resource].Employee E
where D.DeptNo =E.DeptNo and E.EmpNo =W.EmpNo and P.ProjectNo = W.ProjectNo and P.ProjectNo ='P1' and D.DeptName = 'Sales'


/*8.Delete the information in the works_on table for all employees who work for the department located in KW.*/
 --alter table Works_on add constraint c11  
   --   on delete set NULL on update cascade 
delete  Works_on
from Works_on W , [Human_Resource].Employee E ,Company.Department D
where E.EmpNo = W.EmpNo and D.DeptNo = E.DeptNo and D.Location = 'KW'