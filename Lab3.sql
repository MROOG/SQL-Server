use Company_SD

/*1.	Display the Department id, name and id and the name of its manager.*/
select Dnum , Dname , Fname , SSN
from Departments D , Employee E
where D.MGRSSN = E.SSN

/*2.	Display the name of the departments and the name of the projects under its control.*/
select Dname ,Pname
from Departments D inner join Project P
on D.Dnum = P.Dnum


/*3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.*/

select D.* , E.Fname                 /*why he get all two tables??*/
from  Dependent D  , Employee E
where  E.SSN = D.ESSN

/*4.	Display the Id, name and location of the projects in Cairo or Alex city.*/

select Pnumber ,Pname ,Plocation 
from Project
where City in ('Cairo' , 'Alex' )

/*5.	Display the Projects full data of the projects with a name starts with "a" letter*/
select * 
from Project
where Pname like 'a%'

/*6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly*/
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000            /*take care*/


/*7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.*/
select Fname 
from Employee , Works_for , Project
where Dno =10 and Works_for.Hours >=10 and Pname = 'AL Rabwah'        /*check the output*/


/*8.	Find the names of the employees who directly supervised with Kamel Mohamed.*/
select Y.Fname as employee_name 
from Employee X , Employee Y
where X.SSN = Y.Superssn   and X.SSN = 223344



/*9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.*/
select Fname , Pname 
from Employee E  inner join Departments D
on E.Dno = D.Dnum 
inner join Project P
on D.Dnum=P.Dnum


/*10.	For each project located in Cairo City , find the project number,
the controlling department name ,the department manager last name ,address and birthdate.*/

select Pnumber , Dname ,Lname , Address, Bdate
from Project P, Departments D, Employee E
where  P.City = 'Cairo' and P.Dnum = D.Dnum and D.Dnum = E.Dno 

/*11.	Display All Data of the mangers*/
select *
from Employee E ,  Departments D
where E.SSN = D.MGRSSN



/*12.	Display All Employees data and the data of their dependents even if they have no dependents*/
select *
from Employee E left outer join Dependent D
on E.SSN = D.ESSN

/*1.	Insert your personal data to the employee table as a new employee in department
number 30, SSN = 102672, Superssn = 112233, salary=3000.*/
insert into Employee
  values ('Samah' , 'Taher', 102672 , '1996- 11-21' ,'Manzala' , 'F', 3000 , 112233 , 30)

/*2.	Insert another employee with personal data your friend as new employee in
department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.*/

insert into Employee
  values ('kareem' , 'ali', 102660 , '1995-12-13' ,'Manzala' , 'M', Null, Null , 30)


/*3.	Upgrade your salary by 20 % of its last value.*/
update Employee
 set Salary+=.2*Salary
where Fname = 'Samah'


