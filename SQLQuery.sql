--- create database and table.
create database db

create table employee
(
 id int primary key identity,
 emp_name nvarchar(50) not null,
 salary money not null,
 age int null,
 gender bit not null,
 birthdate date not null
)

--- Insert your personal data to the employee table as a new employee.
insert into employee([emp_name],[salary],[age],[gender],[birthdate]) values ('Ali','3000',25,0,'1999-5-9')
--- Insert another employee with personal data your friend as new employee.
insert into employee ([emp_name],[salary],[age],[gender],[birthdate]) values ('Mona','5000',23,1,'2000-3-7')

--- Upgrade the salary to 6000
update employee
set salary='6000'
where id=1

--- delete specific row from a table
delete from employee
where id=2

--- Display all the employees Data.
select * from employee 

 --- change name column in sheet:
select emp_name as Name from employee
select emp_name as Full_Name,salary as Total_Salary from employee

--- show data salary small to big 
select * from employee
order by salary asc

--- show data salary big to small
select * from employee
order by salary desc

--- show data but not id =5
select * from employee
where id !=5

---show data where id = 5 and 8 
select * from employee
where id=5 or id=8

--- show data between two number(5,8)
select * from employee
where id in (5,8)

select * from employee
where id between 5 and 8

---show data name is NULL 
select * from employee
where age is NULL

---show data name start "a" 
select *from employee
where emp_name like 'a%'

---show data name contanue "a" 
select *from employee
where emp_name like '_a%'

---show data name contan 3 char
select * from employee
where emp_name like '___'

---show data name contain "a"  evrywhere
select * from employee
where emp_name like '%a%'

--- names that start with certain letters
select * from employee
where emp_name like '[Na]%'

--- names that don't start with certain letters
select * from employee
where emp_name like '[^na]%'

---show data name from a to m 
select * from employee
where emp_name like '[a-m]%'

--- not
select * from employee
where emp_name like '[^a-m]%'

--- show all data of employee where year of his birthdate = 2000
select * from employee
where year ([birthdate])=2000

--- show all data of employee where month of his birthdate = 3
select * from employee
where month([birthdate])=3

--------------------------
select emp_name ,
case gender 
when 0 then 'Male'
when 1 then 'Female'
else 'nothing'
end 
from [dbo].[employee]

------------------------------
select emp_name, salary,
case 
when salary <=3000 then 'low'
when salary >3000 and salary <=5000 then 'mudium'
when salary >5000 then 'hight'
end totalsalary
from [dbo].[employee]

--------------Built In Function---------------------
select upper([emp_name]) from [dbo].[employee]

select lower([emp_name])from [dbo].[employee]

select [emp_name],len([emp_name]) from [dbo].[employee]

select ltrim([emp_name])as Name from [dbo].[employee] 

select [emp_name],substring(ltrim(([emp_name])),1,2) as Name from [dbo].[employee]

select concat (ltrim([emp_name]),'  ',[salary])from [dbo].[employee]

select GETDATE()

-----------------Aggregating Function---------------------
select max([salary]) from [dbo].[employee]

select min([salary]) from [dbo].[employee]

select avg([salary]) from [dbo].[employee]

select count([id]) from[dbo].[employee]

select sum ([salary]) from [dbo].[employee]


----------------------Using join statement------------------
create database db1

create table department
(
  id int primary key identity,
  dep_name nvarchar(50) not null
)

create table employee
(
id int primary key identity,
emp_name nvarchar(50) not null,
dep_id int foreign key references department(id)
)

select [dep_name] , [emp_name]
from [dbo].[department] join[dbo].[employee]
on [dbo].[employee].dep_id=[dbo].[department].id

--------- Using left outer join statement
select [emp_name],[dep_name]
from [dbo].[employee] left outer join [dbo].[department]
on [dbo].[employee].dep_id=[dbo].[department].id

--------- Using right outer join statement
select [emp_name],[dep_name]
from [dbo].[employee] right outer join [dbo].[department]
on [dbo].[employee].dep_id=[dbo].[department].id

--------- Using FULL outer join statement
select [emp_name],[dep_name]
from [dbo].[employee] FULL outer join [dbo].[department]
on [dbo].[employee].dep_id=[dbo].[department].id

--------------------- 
select [emp_name],[dep_name]
from [dbo].[employee],[dbo].[department]
where [dbo].[employee].dep_id=[dbo].[department].id

------------------------
select [dep_name],sum([salary])
from [dbo].[department] join [dbo].[employee]
on [dbo].[employee].dep_id=[dbo].[department].id
group by [dep_name]
having sum([salary])> 5000
order by sum([salary]) asc


------------------------views----------------------
create view myview1
as
select [salary] from [dbo].[employee]

select * from myview1
order by salary asc
----------
create view myview2
as 
select [emp_name],[dep_name]
from [dbo].[employee] join [dbo].[department]
on [dbo].[employee].dep_id=[dbo].[department].id

select * from [dbo].[myview2]

-------schemabinding
create view nyview3 with schemabinding
as 
select [emp_name] from [dbo].[employee]

select * from [dbo].[nyview3]

drop view [dbo].[nyview3]

---------------------------procedures-----------------------
create proc GetEmployee
as
select [emp_name] from [dbo].[employee]

execute [dbo].[GetEmployee]

Alter proc [dbo].[GetEmployee]
@varID int
as 
select [emp_name] from [dbo].[employee]
where id=@varID

execute [dbo].[GetEmployee] 5

create proc DetEmpData
@varname nvarchar(30)
as 
select [emp_name] from [dbo].[employee]
where [emp_name] like @varname+'%'

execute [dbo].[DetEmpData] 'a'

-------insert procedures---------
create proc InsertDataEmp
@name  nvarchar(30)
,@salary nvarchar(30)
as 
insert into [dbo].[employee] ([emp_name],[salary]) values (@name,@salary)

execute [dbo].[InsertDataEmp] Hager , 6500
select *from [dbo].[employee]

------procedures with condition------
create proc getStudintwithId 
@id int
as
select *from studint
where id =@id

execute getStudintwithId 3 

 --------edit procedures--------
 Alter proc getStudintwithId
 @id int =4
 as
 select *from studint
 where id=@id

 execute getStudintwithId



-----------update procedures----------
create proc UpdateDataEmp
@name nvarchar(30),
@id int
as 
update [dbo].[employee]
set [emp_name]=@name
where id =@id

execute [dbo].[UpdateDataEmp] Omer ,10
select * from [dbo].[employee]

---------delete  data using proc--------
create proc DeleteDataEmp
@id int
as
delete from [dbo].[employee]
where id = @id

execute [dbo].[DeleteDataEmp] 11
select * from [dbo].[employee]


--------------------------Trigger------------------------------------

-----------------instead of---------------------
create trigger inof	on [dbo].[Customers1]
instead of delete 
as 
select * from [dbo].[Customers1];

-- part try 
delete from [dbo].[Customers1];

-----------------for update---------------------
create trigger updatedatefor on [dbo].[Customers1]
for update
as 
print'Updating occur on [Customers1] table '

-- part try 
update [Customers1]  set [f_name] ='AAA' where [customer_id]=5;

-----------------after---------------------
create table LogData
(
id int primary key identity,
Tablename nvarchar(50),
ACtiontype nvarchar(50)	,
ACtiondatetime datetime	,
Columnname nvarchar(50)	,
Oldvalue nvarchar(50)	,
Newvalue nvarchar(50)	
)

-----------------after insert---------------------

create trigger logdatatable on [dbo].[Customers1]
after insert 
as 
declare @pname nvarchar(50) = (select [f_name] from inserted )
declare @plocation nvarchar(50) = (select [city] from inserted )

insert into [dbo].[LogData] ([Tablename],[ACtiontype],[Columnname],[Newvalue])values('Customers1','insert','[f_name]',@pname)
insert into [dbo].[LogData] ([Tablename],[ACtiontype],[Columnname],[Newvalue])values('Customers1','insert','[city]',@plocation)

-- part try 
insert into  [dbo].[Customers1] ([customer_id],[f_name],[city])
values(10,'R','RR')
 

 -----------------after update---------------------
create trigger udatatable on [dbo].[Customers1]
after update 
as 
declare @Oldpname nvarchar(50) = (select [f_name] from inserted )
declare @Oldplocation nvarchar(50) = (select [city] from inserted )

declare @Newpname nvarchar(50) = (select [f_name] from inserted )
declare @Newplocation nvarchar(50) = (select [city] from inserted )

insert into [dbo].[LogData] ([Tablename],[ACtiontype],[Columnname],[Newvalue],[Oldvalue])values('Customers1','Update','[f_name]',@Newpname,@Oldpname)
insert into [dbo].[LogData] ([Tablename],[ACtiontype],[Columnname],[Newvalue],[Oldvalue])values('Customers1','Update','[city]',@Newplocation,@Oldplocation)

-- part try 
update [Customers1]
set [f_name]='nada' ,city='cairo'
where [customer_id] =10;


----------------------------Transaction-----------------------
begin transaction
insert into [dbo].[Customers1] (customer_id,f_name)
values(12,'nada')
if @@ERROR >0
rollback
else
commit
select * from [Customers1];



---- Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
create function getnum(@num1 int, @num2 int)
returns @temp table 
              (nom int)
as
begin
    while @num1 < @num2
	begin
	    set @num1 += 1
		if @num1 = @num2
		   break
		insert into @temp values(@num1)
	end
	return
end

--- drop function getnum

select* from getnum(2,7)


--- Create inline function that takes Student No and returns Department Name with Student full name.
create function getstd(@stno int)
returns table     
as
return (
     select s.st_fname + ' ' + s.st_lname full_name, d.dept_name
	 from Student s join department d
	 on d.dept_id = s.dept_id
	 where s.St_Id = @stno
	 )

select* from getstd(10)


--- Write a query that returns the Student No and Student first name without the last char
select St_Id, SUBSTRING(St_Fname, 1, len(st_fname) -1)
from Student


--- Wirte query to delete all grades for the students Located in SD Department 
delete from Stud_Course
where St_Id in (
            	select s.St_Id
				      from Department d join Student s
				      on d.Dept_Id = s.Dept_Id
				      where d.Dept_Name = 'SD'
				        )

