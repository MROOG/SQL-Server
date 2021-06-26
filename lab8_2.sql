use [SD32-Company]

/*1)Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'.*/

create view v_clerk
as
select HE.EmpNo ,P.ProjectNo , W.Enter_Date 
from Human_Resource.Employee HE , Works_on W , Project P
where HE.EmpNo = W.EmpNo and P.ProjectNo =W.ProjectNo and W.Job = 'Clerk'

select*from v_clerk


/*
2)	 Create view named  “v_without_budget” that will display all the projects data 
without budget*/

create view v_without_budget
as
select*
from Project P
where P.Budget is null

select* from v_without_budget


/*3)	Create view named  “v_count “ that will display the project name and the # of jobs in it*/
alter view v_count()
as
select P.ProjectName , count(W.Job) n0_jobs
from Project P , Works_on W
where P.ProjectNo = W.ProjectNo
group by P.ProjectName

select*from v_count


/*4)	 Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’
use the previously created view  “v_clerk”*/

alter view  v_project_p2
as
select EmpNo , ProjectNo
from v_clerk
where ProjectNo = 'p2'
                                                                   
/*test*/  select*from v_project_p2


/*5)modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 */
alter view v_without_budget
as
select*
from Project P
where P.ProjectNo in ('p1' , 'p2')

select* from v_without_budget


/*6)	Delete the views  “v_ clerk” and “v_count”*/

delete  v_clerk
--cannot delete as takes from more than table


/*7)	Create view that will display the emp# and emp lastname who works on dept# is ‘d2’*/

create view ddd
as
select HE.EmpNo ,HE.EmpLname
from Human_Resource.Employee HE , Company.Department D
where D.DeptNo = HE.DeptNo and D.DeptNo = 'd2'


select*from ddd


/*8)	Display the employee  lastname that contains letter “J”
Use the previous view created in Q#7*/
select ddd.EmpLname
from ddd
where EmpLname like '%j%'


/*9)	Create view named “v_dept” that will display the department# and department name*/
create view v_dept
as
select D.DeptNo , D.DeptName
from Company.Department D


/*10)	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’*/
insert into v_dept
values ('d4','Development')

/*11)	Create view name “v_2006_check” that will display employee#, the project #where
he works and the date of joining the project which must be from the first of January and
the last of December 2006.this view will be used to insert data so make sure that the coming new data must match the condition*/

alter view v_2006_check
as
select HE.EmpNo , P.ProjectNo
from Human_Resource.Employee HE , Project P , Works_on W
where HE.EmpNo =W.EmpNo and P.ProjectNo = W.ProjectNo and W.Enter_Date between '1.1.2006' and '12.30.2006'
with check option 

select*from v_2006_check