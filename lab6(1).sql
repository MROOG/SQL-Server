use [SD32-Company]

create rule r1 as @x in ('NY' ,'DS' ,'KW')
create default df1 as 'NY'
sp_addtype loc , 'nvarchar(20)'
sp_bindrule r1 , loc
sp_bindefault df1 , loc


create table Department
(
  DeptNo nchar(2) PRIMARY KEY ,
  DeptName nvarchar(20),
  Location loc

)
 
create table Employee
(
  EmpNo int primary key,
  EmpFname nvarchar(20) not null,
  EmpLname nvarchar(20) not null ,
  DeptNo  nchar(2) foreign key references Department (DeptNo),
  Salary  int unique 
)

create rule r2 as @X < 6000
sp_bindrule r2 , 'Employee.Salary'

insert into Department
values ('d1','Research','NY'),('d2','Accounting','Ds')

insert into Employee
values (2538 , 'Mathwe' , 'Smith' ,'d2' ,2500),(10102 ,'Ann' ,'Jones','d2',3000)

insert into Project
values ('P1','Apollo',120000),('P2','Gemini',95000)

insert into Works_on
values (10102 ,'P1','Analyst', '2006.10.1'),(10102 ,'P2','Manager', '2012.10.1')

--------------------------------------------------------------------------------------------------------------------
/*1-Add new employee with EmpNo =11111 In the works_on table [what will happen]*/
insert into Works_on
values (11111 ,'P1','Analyst', '2006.10.1')         --this value must exist in emp table(pk)
/*2-Change the employee number 10102  to 11111  in the works on table [what will happen]*/
update Works_on
	set EmpNo = 11111
where EmpNo = 10102

/*3-Modify the employee number 10102 in the employee table to 22222. [what will happen]*/

update Employee
	set EmpNo =22222                                                                                 
where EmpNo = 10102

/*4-Delete the employee with id 10102*/
delete from Employee 
where EmpNo = 10102

/*1-Add  TelephoneNumber column to the employee table[programmatically]*/
alter table Employee add TelephoneNumber int 


/*2-drop this column[programmatically]*/
alter table Employee drop column TelephoneNumber


