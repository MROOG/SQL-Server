use ITI
/*1 Create a view that displays student full name, course name if the student has a grade more than 50.*/
create view vstud
as
  select S.St_Fname+' '+S.St_Lname as full_name , C.Crs_Name
  from Student S , Stud_Course SC , Course C
  where S.St_Id = SC.St_Id and SC.Crs_Id =C.Crs_Id and SC.Grade >50


select* from vstud

/*2.Create an Encrypted view that displays manager names and the topics they teach. */


alter view Vmange
with encryption 
as
select I.Ins_Name , T.Top_Name
from Instructor I , Ins_Course IC ,Course C , Topic T ,Department D
where I.Ins_Id = IC.Ins_Id and C.Crs_Id =IC.Crs_Id and T.Top_Id =C.Top_Id and D.Dept_Id = I.Dept_Id


select*from Vmange


/*3.	Create a view that will display Instructor Name, Department Name for the ‘SD’ or
‘Java’ Department “use Schema binding” and describe what is the meaning of Schema Binding*/

create view vinsti
with schemabinding 
as
select I.Ins_Name , D.Dept_Name
from dbo.Instructor I , dbo.Department D
where D.Dept_Id = I.Dept_Id and D.Dept_Name in ('SD' ,'Java')

select* from vinsti

/*
4.	 Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
Note: Prevent the users to run the following query 
Update V1 set st_address=’tanta’
Where st_address=’alex’;*/

alter view V1
as
select*
from Student S
where S.St_Address in ('Alex','Cairo')
with check option


update V1
set St_Address = 'tanta'
where St_Address = 'Alex'


select * from V1

/*5.Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?*/
create clustered index Inx1
on Department (Manager_hiredate)           --cannot

create nonclustered index Inx1
on Department (Manager_hiredate)


/*6.Create index that allow u to enter unique ages in student table. What will happen? */
create unique index Inx2                             --cannot 
on Student(St_Age)

/*7.Create temporary table [Session based] on Company DB to save employee name and his today task.*/

create table #tapp
(
  emp_name varchar(20) ,
  task nvarchar(50)
)


/*8.Create a view that will display the project name and the number of employees work on it. “Use Company DB”*/

use Company_SD

	
	create view comp
	as
		select Pname , count(SSN) as nnnn 
		from Employee E , Works_for W, Project P
		where E.SSN =W.ESSn and P.Pnumber= W.Pno
		group by P.Pname

select*from comp



/*9.	Using Merge statement between the following two tables [User ID, Transaction Amount]*/

create table #Dialy_Transaction
 (
  ID int ,
  amount nvarchar(20)
  )
insert into #Dialy_Transaction
 values (1,1000) , (2,2000) ,(3,1000)

 create table #Last_tranaction
 (
  ID int ,
  amount nvarchar(20)
  )
insert into #Last_tranaction
 values (1,1000) , (2,2000) ,(3,1000)


Merge into #Last_tranaction as L
using #Dialy_Transaction as D
on L.ID = D.ID
when matched then 
update
set L.amount = D.amount 
when not matched then 
 insert
 values (D.ID , D.amount) ;