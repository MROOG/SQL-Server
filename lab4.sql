use Company_SD
/*1.	Display (Using Union Function)
a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
b.	 And the male dependence that depends on Male Employee.*/


select D.Dependent_name , D.Sex 
from Dependent D , Employee E
where E.SSN = D.ESSN and E.Sex = 'F' and D.Sex = 'F'
union 
select D.Dependent_name , D.Sex 
from Dependent D , Employee E
where E.SSN = D.ESSN and E.Sex = 'M' and D.Sex = 'M'

/*2.	For each project, list the project name and the total hours per week ((for all employees)) spent on that project.*/
select Pname , Hours
from Project P inner join Works_for W            --third join or not ?!!
on P.Pnumber = w.Pno
inner join Employee E
on E.SSN = W.ESSn


/*3.	Display the data of the department which has the smallest employee ID over all employees' ID.*/
select D.* 
from Departments D , Employee E
where  D.Dnum = E.Dno                                
and SSN =(select min(SSN) from Employee)


/*4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.*/
select D.Dname , Max(E.Salary) as ma ,Min(E.Salary) as mi ,avg(E.Salary) as av
from Departments D ,Employee E
where D.Dnum = E.Dno
group by D.Dname

/*5.	List the last name of all managers who have no dependents*/
--select  Lname 
--from Employee E , Departments D , Dependent Dt
--where E.SSN = D.MGRSSN and E.SSN = Dt.ESSN and Dt.ESSN is null  
                                                       
select Lname
from Employee E  join Departments D
on E.SSN = D.MGRSSN
inner  join Dependent Dt
on E.SSN = Dt.ESSN  
where Dt.ESSN is null


/*6.	For each department-- if its average salary is less than the average salary
of all employees-- display its number, name and number of its employees.*/
select D.Dnum , Dname , count (E.Dno)
from Departments D , Employee E
where D.Dnum = E.Dno
group by D.Dname ,D.Dnum
having avg(E.Salary)<(select avg(Salary) from Employee)

/*7.	Retrieve a list of employees and the projects they are working on 
ordered by department and within each department, ordered alphabetically by last name, first name.*/
select Fname +' '+Lname as ful_name , P.Pname
from Employee E , Project P , Departments D
where D.Dnum = E.Dno and D.Dnum=P.Dnum                      
order by D.Dnum , E.Lname ,E.Fname

/*8.	Try to get the max 2 salaries using subquery*/
select max (Salary)
from Employee
union
select max(Salary)
from Employee
where Salary < (select max(Salary) from Employee)

 /*9.	Get the full name of employees that is similar to any dependent name*/
 select Fname+' '+Lname as full_name
 from Employee
 intersect
 select Dependent_name
 from Dependent

/*10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% */
update E 
set Salary=1.3*Salary
from Employee E , Departments D , Project P 
where D.Dnum = E.Dno and D.Dnum=P.Dnum and Pname = 'Al Rabwah'


/*11.	Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.*/
select E.SSN , E.Fname 
from Employee E 
where exists (select ESSN from Dependent D where D.ESSN = E.SSN)


--Dml
/*1.	In the department table insert new department called "DEPT IT" ,
with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'*/

insert into Departments 
values('DEPT IT' ,100 , 112233 ,'1-11-2006')

/*2.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be  
the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 

a.	First try to update her record in the department table
b.	Update your record to be department 20 manager.
c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)*/

-------------------------------her data--------------------------------------------------
update Departments 
set Departments.MGRSSN = 968574
where Departments.Dnum =100

update Employee 
set Dno = 100
where SSN = 968574 
-------------------------------------my data------------------------------------------------
update Departments 
set Departments.MGRSSN = 102672
where Departments.Dnum =20

update Employee 
set Dno = 20
where SSN = 102672 
---------------------------------------------------------------
update Employee 
set Employee.Superssn =102672
where Employee.SSN = 102660





/*3.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so
try to delete his data from your database in case you know that you will be temporarily in his position.
Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works
in any projects and handle these cases).*/


delete from Dependent
where Dependent.ESSN = 223344

update Departments
set MGRSSN = 775522
where MGRSSN =223344

update Employee
set Superssn = 775522
where Superssn = 223344

update Works_for
set ESSn = 775522
where ESSn = 223344

delete from Employee
where SSN = 223344