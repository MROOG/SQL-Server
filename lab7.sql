use ITI
1.	/* Create a scalar function that takes date and returns Month name of that date.*/

create function month_name (@x date)
returns nvarchar(50)
begin 
declare @mo_name nvarchar (50)
select @mo_name=  datename (mm , @x)
return @mo_name
end 

/*test*/ select dbo.month_name('5/5/2005')
--__________________________________________________________________________________________________________________________

/*2.Create a multi-statements table-valued function that takes 2 integers and returns the values between them.*/

alter function sub (@A int , @B int )
returns  @res table 
  ( 
	res_ int
  )
as 
begin
 declare @bb int = @A
 set @bb +=1
 while (@bb >= @A and @bb< @B)
	begin
	insert into @res select @bb
	set @bb +=1
	end
return
end
 select* from dbo.sub(1,7)
/*test*/
--__________________________________________________________________________________________________________________________

/*3.Create a tabled valued function that takes Student No and returns Department Name with Student full name.*/

create function dept_info (@x int )
returns @tt table
		(
		 --ST_No int ,
		 D_name nvarchar (50),
		 S_full  nvarchar (50)
		 )
as
	begin 
	  insert into @tt
	  select D.Dept_Name , S.St_Fname+'  '+S.St_Lname
	  from Student S , Department D
	  where D.Dept_Id =S.Dept_Id and S.St_Id = @x
	  return
	end
/*test*/   select* from dept_info (4)
--__________________________________________________________________________________________________________________________

/*4.	Create a scalar function that takes Student ID and returns a message to user 
a.	If first name and Last name are null then display 'First name & last name are null'
b.	If First name is null then display 'first name is null'
c.	If Last name is null then display 'last name is null'
d.	Else display 'First name & last name are not null'*/

alter function user_msg (@id int)
returns  nvarchar(50)
	begin
		declare @msg nvarchar(50)
		declare @ff nvarchar(50)
		declare @ll nvarchar(50)
		select @ff= S.St_Fname ,@ll= S.St_Lname
		from Student S
		where S.St_Id = @id
		

		if @ff is null and @ll is null
			set @msg = 'First name & last name are null'
		if @ff is null and @ll is not null
			set @msg = 'first name is null'
		if @ff is not null and @ll is null
			set @msg = 'last name is null'
		else
			set @msg = 'First name & last name are not null'
		return @msg
		 
	end
/*test*/  select dbo.user_msg (13)
//*--------------------------------------------------------------------------------*/
create function mg2 (@nn int )
returns nvarchar(50)
	begin
			declare @msg nvarchar(50)
			select @msg =
			case 
				when St_Fname is null and St_Lname is null then 'First name & last name are null'
				when St_Fname is null and St_Lname is not null then 'First name is null'
				when St_Fname is not null and St_Lname is null then 'last name is null'
				else 'First name & last name are not null'
			end 
			from Student S
			where S.St_Id =@nn
			return @msg
	end

/*test*/  select dbo.mg2(13)


--__________________________________________________________________________________________________________________________

/*5.Create a function that takes integer which represents manager ID and displays
department name, Manager Name and hiring date */

create function mang (@mg_id int)
returns  @info table 
   (
	d_name nvarchar (20),
	mg_name nvarchar (20),
	h_date date 
   )
as
begin
	insert into @info
	select D.Dept_Name , I.Ins_Name ,D.Manager_hiredate
	from Department D , Instructor I 
	where D.Dept_Id =I.Dept_Id and @mg_id = I.Ins_Id
	return
end 

/*test*/ select* from mang(5)

--__________________________________________________________________________________________________________________________

/*6.	Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table 
Note: Use “ISNULL” function*/

create function getname (@Nm varchar(20))
returns @tname table
	(
		fnm varchar(20),
		lnm varchar(20),
		funm varchar(20)
	)
as
 begin
	if @Nm = 'first name'
	insert into @tname
	select S.St_Fname ,'   ','   '
	from Student S
	if @Nm = 'last name'
	insert into @tname
	select '   ',S.St_Lname,'   '
	from Student S
	if @Nm = 'full name'
	insert into @tname
	select '   ','   ',S.St_Fname+' '+S.St_Lname
	from Student S
	return
 end
/*test*/  select*from getname('last name')


--__________________________________________________________________________________________________________________________

/*
7.	Write a query that returns the Student No and Student first name without the last char*/

select S.St_Id ,left( S.St_Fname ,len(S.St_Fname)-1)
from Student S



