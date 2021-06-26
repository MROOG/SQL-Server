/*1.Create a cursor for Employee table that increases Employee salary by 10% if Salary 
<3000 and increases it by 20% if Salary >=3000. Use company DB*/
use Company_SD
declare c1 cursor
for select Salary
	from Employee

for update 
declare @SAL int 
open c1
fetch c1 into @SAL
while @@FETCH_STATUS = 0
	begin
		if @SAL >= 3000
		begin
			update Employee
			set Salary = @SAL*1.2
			where current of c1                       --to update the raw that the pointer refer to
		end
		else
		begin
			update Employee
			set Salary = @SAL*1.1
			where current of c1
		end
		fetch c1 into @SAL
	end
close c1 
deallocate c1

--------------------------------------------------------------------------------------------------------------------------------------------------------
/*2.Display Department name with its manager name using cursor. Use ITI DB*/
use ITI
declare c2 cursor 
for  select D.Dept_Name , I.Ins_Name
     from Department D , Instructor I
	 where D.Dept_Id = I.Dept_Id
declare @Dname varchar(20) , @Mname varchar(20)
open c2
fetch c2 into @Dname , @Mname
while @@FETCH_STATUS = 0
begin
	select @Dname , @Mname
	fetch c2 into @Dname , @Mname
end
close c2
deallocate c2


--------------------------------------------------------------------------------------------------------------------------------------------------------
/*3.Try to display all students first name in one cell separated by comma. Using Cursor */
use ITI
declare c3 cursor
for select St_Fname
    from Student
--for read only
declare @Fnames nvarchar (200) = ''
open c3
fetch c3 into @Fnames
while @@FETCH_STATUS = 0
begin
	set @Fnames= concat(@Fnames ,' , ')                        --get only one value !!!
	fetch c3 into @Fnames
end
select @Fnames
close c3
deallocate c3








--------------------------------------------------------------------------------------------------------------------------------------------------------
/*4.Create full, differential Backup for SD30_Company DB.*/        --saved it in my pc   

/*5.Use import export wizard to display students data (ITI DB) in excel sheet*/    --saved it in my pc  

/*6.Try to generate script from DB ITI that describes all tables and views in this DB*/


-- I made the script in new query attache called (script for iti (Q6)) , for tables only as the view I had made was deleted


--------------------------------------------------------------------------------------------------------------------------------------------------------
/*7.Create Snapshot for CompanyDB.*/
create database snap_1
on
(
	name = 'Company_SD' ,
	filename = 'D:\snap_1'
)
as snapshot of Company_SD

--------------------------------------------------------------------------------------------------------------------------------------------------------
/*8.Create job for backup ITI DB every day at 12:00PM*/

backup database ITI                    -- I found sql server agent disabled and i coudnot add a job !!
to disk = 'D:\bac(12PM)'


-------------------------------------------------------------------------------------------------------------------------------------------
/*9.Create a sequence object that allow values from 1 to 10 without cycling in a specific column and test it (self study).*/


create sequence so1
as int
start with 1
increment by 1
Maxvalue 10
no cycle

select next value for so1