/*1.Display all the data from the Employee table (HumanResources Schema) 
As an XML document “Use XML Raw”. “Use Adventure works DB” 
A)	Elements
B)	Attributes */

use AdventureWorks2012
select* from HumanResources.Employee
for xml raw
select* from HumanResources.Employee
for xml raw , Elements

--------------------------------------------------------------------------------------------------------------------------
/*2.Display Each Department Name with its instructors. “Use ITI DB”
A)	Use XML Auto
B)	Use XML Path */

--A
use ITI
select D.Dept_Name , I.Ins_Name
from Department D ,Instructor I
where D.Dept_Id = I.Dept_Id
for xml auto , elements

--B
select  D.Dept_Name "@Dname" , I.Ins_Name "@Iname"
from Department D ,Instructor I
where D.Dept_Id = I.Dept_Id
for xml path ('Student')

--------------------------------------------------------------------------------------------------------------------------
/*3 on the other file*/

/*4.Create a stored procedure to show the number of students per department.[use ITI DB]*/*/
use ITI
create proc STNo
as
select D.Dept_Name ,  count (S.St_Id)
from Student S ,Department D
where D.Dept_Id = S.Dept_Id
group by D.Dept_Name

 STNo 

-------------------------------------------------------------------------------------------------------------------
/*5.Create a stored procedure that will check for the # of employees in the project p1
if they are more than 3 print message to the user “'The number of employees in the 
project p1 is 3 or more'” if they are less display a message to the user “'The following
employees work for the project p1'” in addition to the first name and last name of each one. [Company DB]*/


use [SD32-Company]
 
create proc empNO
as
declare @No int 
select @No = count(E.EmpNo) 
from Human_Resource.Employee E ,Works_on W , Project P
where E.EmpNo = W.EmpNo and P.ProjectNo =W.ProjectNo and P.ProjectNo = 'p1'
group by P.ProjectNo
if @No > 3  select 'The number of employees in the project p1 is 3 or more'
esle select 'The followingemployees work for the project p1'
/*test*/  empNo

---------------------------------------------------------------------------------------------------------------------------------

/*6.Create a stored procedure that will be used in case there is an old employee
has left the project and a new one become instead of him. The procedure should take
3 parameters (old Emp. number, new Emp. number and the project number) and it will
be used to update works_on table. [Company DB]*/
use [SD32-Company]
alter proc change @Old_empNo int, @New_empNo int , @ProNo varchar(20)
as

update Works_on 
set EmpNo = @New_empNo
from Human_Resource.Employee HE , Works_on W
where HE.EmpNo = @Old_empNo and HE.EmpNo = W.EmpNo and W.ProjectNo = @ProNo 




change 2538 ,25348,'p3'





---------------------------------------------------------------------------------------------------------------------------------
/*7.	Create an Audit table with the following structure 
ProjectNo 	UserName 	ModifiedDate 	Budget_Old 	Budget_New 
p2 	Dbo 	2008-01-31	95000 	200000 

This table will be used to audit the update trials on the Budget column (Project table, Company DB)
Example:
If a user updated the budget column then the project number, user name that made that update, 
the date of the modification and the value of the old and the new budget will be inserted into the Audit table
Note: This process will take place only if the user updated the budget column*/
use [SD32-Company]
create table audit_
	(
		ProjNo nvarchar(20) ,
		UserName nvarchar(50),
		ModifiedDate date ,
		Budget_Old int ,
		Budget_New int 
	)	

alter trigger tt
on Project
instead of update
as
	if update(Budget)
	begin
		declare @new int , @old int ,@PN nvarchar(20)
		select @new = Budget from inserted
		select @old = Budget from deleted
		select @PN = ProjectNo from Project
		insert into audit_
		values (@PN ,suser_name(),getdate(),@old ,@new)
	end


update Project
set Budget = 6551                                     
where Project.ProjectName = 'Apollo'










---------------------------------------------------------------------------------------------------------------------------------
/*
8.	Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
“Print a message for user to tell him that he can’t insert a new record in that table”*/
use ITI
create trigger T1
on Department
instead of insert
as
select 'you can’t insert a new record to this table'

insert into Department (Dept_Id ,Dept_Name)
values (50 , 'SD')

---------------------------------------------------------------------------------------------------------------------------------
/*9 Create a trigger that prevents the insertion Process for Employee table in March [Company DB].*/
use Company_SD
alter trigger T2
on Employee
instead of insert
as	
	if format(getdate(),'MMMM')='December'	
		begin
			select 'insertion Process is prevented'
			--insert into Employee
			--select * from deleted
		end


insert into Employee
values ('hossam' , 'mok' ,55566 ,null , null , 'M' , 4000 , null , null)


---------------------------------------------------------------------------------------------------------------------------------

/*10.Create a trigger that prevents users from altering any table in Company DB*/
use Try
create trigger T3
on info 
instead of insert , update , delete
as
 select 'Nooooooooo'
use Try
create trigger T3_2
on work 
instead of insert , update , delete
as
 select 'Nooooooooo'

insert into info
values (222,'sam','doc')





/*11.	Create a trigger on student table after insert to add Row in Student Audit table
(Server User Name , Date, Note) where note will be “[username] Insert New Row with Key=
[Key Value] in table [table name]”
Server User Name		Date   	Note */
use ITI
create table ST_Audit
	
		(ser_name nvarchar(50),
		Date_  date,
		Note nvarchar(70))
	

alter trigger T5
on Student
after insert
as 
	begin
		declare @key int
		select @key = St_Id from inserted
		insert into ST_Audit
		values (SUSER_SNAME(),getdate(), concat( Suser_name() ,'insert New Row with key=' , @key ,'in table Student'))
		--execute ('select+ Suser_name()+insert New Row with key=' + @key +'in table Student')
	end
		
insert into Student
values (18,'sam','ali','cairo',24,40,null)


----------------------------------------------------------------------------------------------------------------------------------
/*12.Create a trigger on student table instead of delete to add Row in Student Audit table
(Server User Name, Date, Note) where note will be“ try to delete Row with Key=[Key Value*/

create trigger Td
on Student
instead of delete
as
	begin
		declare @kk int 
		select @kk = St_Id from deleted
		insert into ST_Audit
		values (suser_name() , getdate(), concat('try to delete Row with key = ' ,@kk))
	end

/*test*/  delete from Student
		  where St_Id = 18