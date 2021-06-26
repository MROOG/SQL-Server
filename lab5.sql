use ITI
/*1.	Retrieve number of students who have a value in their age. */
select count (St_Age)
from Student

/*2.	Get all instructors Names without repetition*/
select distinct Ins_Name
from Instructor

/*3.	Display student with the following Format (use isNull function)
Student ID	Student Full Name	Department name*/
		
select  isnull (S.St_Id  , 555) as stu_id  ,S.St_Fname+' '+S.St_Lname as Student_Full_Name,D.Dept_Name as Department_name 
from Student S   , Department D                          --problem with isnull??

/*4.	Display instructor Name and Department Name 
Note: display all the instructors if they are attached to a department or not*/
select Ins_Name ,Dept_Name
from Instructor I left outer join Department D
on D.Dept_Id = I.Dept_Id

/*5.	Display student full name and the name of the course he is taking
For only courses which have a grade*/
select S.St_Fname+' '+S.St_Lname as St_full_name , C.Crs_Name
from Student S,Stud_Course SC , Course C
where S.St_Id = SC.St_Id and C.Crs_Id =SC.Crs_Id and SC.Grade is not null


/*6.	Display number of courses for each topic name*/
select count (C.Crs_Id) , T.Top_Name
from Course C , Topic T
where T.Top_Id = C.Top_Id
group by T.Top_Name


/*7.	Display max and min salary for instructors*/
select max (I.Salary) ,min(I.Salary)
from Instructor I


/*8.	Display instructors who have salaries less than the average salary of all instructors.*/
select I.Ins_Name
from Instructor I
where I.Salary < (select avg (Salary) from Instructor)

/*9.	Display the Department name that contains the instructor who receives the minimum salary.*/
select D.Dept_Name
from Department D , Instructor I
where D.Dept_Id =I.Dept_Id and I.Salary =(select min (Salary) from Instructor)


/*10.	 Select max two salaries in instructor table. */
select top(2) Salary
from Instructor
order by Salary desc


/*11. Select instructor name and his salary but if there is no salary display instructor bonus. “use one of coalesce Function”*/
select I.Ins_Name , coalesce (I.Salary , 512)
from Instructor I


/*12.	Select Average Salary for instructors */
select avg (Salary)
from Instructor

/*13.	Select Student first name and the data of his supervisor */

select Y.St_Fname as student ,  X.* 
from Student X , Student Y
where Y.St_Id =X.St_super

/*14.	Write a query to select the highest two salaries in Each Department
for instructors who have salaries. “using one of Ranking Functions”*/
select*
from (select * , Dense_Rank() over (partition by I.Dept_Id  order by Salary desc )as DR
       from Instructor I
	    where I.Salary is not null) as x
where DR <= 2
---------------------------------------------------------------------------------
--what is the other sol??--select top (2) Salary as maxSalary , Dept_Id
--from Instructor  
--order by Dept_Id, Salary desc


/*15. Write a query to select a random  student from each department.  “using one of Ranking Functions”*/
select top(1)*
from Student
order by newid ()
-------------------by one of Ranking Functions ----------------------------------
select *
from (select * , Row_number()over ( partition by Dept_Id order by newid()) as RN
       from Student) as x 
where RN = 1