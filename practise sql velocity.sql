-- create a database computer
create database computer;
show databases; -- gives all database
use computer;

-- create table lenovo 
create table lenovo(lid int,ltype varchar(15),price int );
show tables;
show create table lenovo;
desc lenovo;

 -- alter into  lenovo tables
 alter table lenovo add column ram int;
 desc lenovo;
 
 -- add column after price and before ram
 alter table lenovo add storage int after price;
 desc lenovo;
  
 -- modify column ltype varchar(15) to varchar(20)
 alter table lenovo modify ltype varchar(20);
 desc lenovo;
  
  -- rename columns name storage to rom 
  alter table lenovo rename column storage to rom;
  desc lenovo;
  
  -- rename table lenovo to lenovo to dell
  alter table lenovo rename to dell;
  desc lenovo; -- gives the error
  desc dell;
  
  -- remove column rom 
  alter table dell drop column rom;
desc dell;

-- insert data into table
insert into dell values(101,'notebook',20000,8);
insert into dell values(102,'chromebook',40000,16);
insert into dell values(103,'gaming',60000,32);
select * from dell;
select lid,ltype from dell;

-- used of where display row having price greater than 50000
select * from dell where price>50000;
select * from dell where lid in(101,103);
select * from dell where price between 30000 and 70000;
select * from dell where lid=101 and ltype="notebook";
select * from dell where lid=101 or price=100;

update dell set ltype = 'dtype';

alter table dell add internship int;
desc dell;
select * from dell;
update dell set internship=2;



use computer;
desc dell;

--  Not Null value constraints

use college;
create table empnu(eid int,empname varchar(20), salary int);  --  table contain null value
create table empnu1(eid int NOT NULL,empname varchar(20), salary int NOT NULL);  -- Table not contain null value  
desc empnu;
desc empnu1;

-- this get excuted with null values
insert into empnu values(1,'krushna',9000);  
insert into empnu values(2,'krushna',2);
insert into empnu values(3,'krushna',9000);
select * from empnu;

 -- this does not get excuted with null values
insert into empnu1 values(null,'krushna',9000);  -- not insert error
insert into empnu1 values(2,'krushna',null); -- not insert error
insert into empnu1 values(3,'krushna',9000); -- inserted
select * from empnu1;


drop table empnu;
create table empnu(eid int,empname varchar(20), salary int);
-- to apply Not Null constraints
alter table empnu modify column eid int NOT NULL; -- apply not null cosntraint
alter table empnu modify column eid int; --  removing not null constraints
 
 
  -- unique constraints
 
 alter table empnu modify column eid int unique;
 insert into empnu values(1,'bhsuahn',90900);-- gives error duplicate entry


 -- primary key = unique + Not Null
create table emp2(eid int primary key, salary int);
desc emp2;

insert into emp2 values(1,9000); -- inserted 
insert into emp2 values(null,9888); --  gives error

alter table emp2 drop primary key; --  drop primary key


-- foreign key = refer a primary key of another table

use college1;
create table student(sid int, sname varchar(20),address varchar(20));
desc student;
select * from student;
insert into student values(101,'krushna','padhegaon');
insert into student values(102,'tejas','shrirampur');
insert into student values(103,'harshal','jalgoan');
insert into student values(104,'vishal','pune');
insert into student values(105,'vijay','moon');
alter table student modify column sid int primary key;
select * from student;


create table course_1 (course_id int ,course_name varchar(20),s_id int,
foreign key(s_id) references student(sid));

insert into course_1 values(1,'data science',101);
insert into course_1 values(2,'java',109);  -- error: cannot add or update a child row a foregin key contriant fail
insert into course_1 values(2,'java',101);

select * from course_1;

insert into course_1 values(3,'cyber security',102);


-- can not delete or update parent row
delete from student where sid=102; -- gives error

delete from course_1 where s_id=102; -- 1st we need to delete that value from child class
delete from student where sid=102;  --  than from parent class
select * from student;
-- we can't delete values which are store as foriegn key in a child table , so to do that we need to 1st delete it from child class and then parent class
-- but using "on delete cascade" , "on update cascade" this at the end of foriegn key query we can delete value in parent class directly and using this it get reflected 
-- to child class.

drop table course_1;
select * from course_1;

--  used of cascade 
create table course_1 (course_id int ,course_name varchar(20),s_id int,
foreign key(s_id) references student(sid)
on delete cascade
on update cascade
);


select * from student;
select * from course_1;


-- on delete cascade
insert into course_1 values(3,'cyber security',101);
delete from student where sid=101; -- from both the table 101 id get deleted

-- on update cascade
insert into course_1 values(10,'data sci',103);
update student set sid=113 where sid=103; -- on both table value get replaced



-- day 4


-- check : used to check for a condition

use college1;
-- we want that user enter only gender as m or f other than m and f gives error
create table emp(eid int, ename varchar(20),gender char(1) check(gender in ('m','f')) );
insert into emp values(1,'krushna','m'),
(2,'bhushan','m'),
(3,'rucha','f');
select * from emp;

insert into emp  values(4,'nihar','d'); --  gives error
insert into emp  values(4,'nihar','m');

select * from emp;

select * from student;

alter table student modify column sid int check(sid>100);

-- to drop above constraints sid > 100 we need to find the constraints.... to find name we used query(show create table student;) which show the constraint used in table
-- alter table table_name drop constraint constraint_name;

show create table student; -- copy the output and paste it in new file
alter table student drop constraint student_chk_1;

select * from student;


show create table student;


-- default  : The DEFAULT constraint is used to set a default value for a column
-- The default value will be added to all new records, if no other value is specified. 

create table teachers(tid int, teacher_name varchar(20),subject varchar(10) default 'math');
select * from teachers;
insert into teachers values(1,'bankar','marathi');
insert into teachers(tid,teacher_name) values(1,'bankar');


select * from teachers;
show  create table teachers;

delete from teachers where tid =1;
alter table teachers modify tid int unique;

insert into teachers values(1,'bankar','marathi');
insert into teachers(tid,teacher_name) values(2,'patil');

alter table teachers alter subject drop default; -- default constraints is removed



-- Auto-increment:  allows a unique number to be generated automatically when a new record is inserted into a table.
-- auto-increament columns must have key(it would be primary or unique)

create table student_7th(sid int auto_increment primary key,sname varchar(20));
insert into student_7th(sname) values('bhushan');
insert into student_7th(sname) values('krushna');
select * from student_7th;

alter table student_7th auto_increment=100;
insert into student_7th(sname) values('nihar');

-- The ORDER BY keyword is used to sort the result-set in ascending or descending order.
-- The ORDER BY keyword sorts the records in ""ascending order by default"". To sort the records in descending order, use the ""DESC keyword"" .
use college;
select * from emp_nn;
alter table emp_nn modify empid int auto_increment primary key;
insert into emp_nn(empname,salary) values('krusha',2000),('bhushan',3000),('om',4000),('ninad',5000),('omkar',6000),('adi',7000),('malvika',8000);
select * from emp_nn;

-- order by - 
select * from emp_nn order by empname; -- sort by empname a-z
select * from emp_nn order by salary; -- sort by salary 
select * from emp_nn order by empname desc; -- sort in descending
select * from emp_nn order by empname,salary; -- sort by empname and salary by group
select * from emp_nn where empname='a' order by salary ; -- sort where empname is 'a'
insert into emp_nn(empname,salary) values('a',1300),('a',1000),('a',1100),('a',1500),('a',1300),('a',1400);



 -- distinct : The SELECT DISTINCT statement is used to return only distinct (different) values.
select distinct empname from emp_nn;

-- fetch:  unique record from a table
select distinct * from emp_nn;


-- LIMIT :  clause is used to specify the number of records to return.
-- limit offset, no _of_rows_to_read
-- offset : no of rows to skip from top,default value of offset is 0

select * from emp_nn;
-- read rows from 5 to 8
select * from emp_nn limit 4,4;
-- read top 5 rows
select * from emp_nn limit 5;
-- 5th highest salary 
select * from emp_nn order by salary desc limit 4,1;
-- 5th lowest salary 
select * from emp_nn order by salary desc limit 4,1;
select distinct salary from emp_nn order by salary desc limit 4,1; -- if duplicate salary are there or salary with same figure 


-- aggregate functions: db return single value
-- sum,avg,min,max,count

select min(salary) from emp_nn;
select max(salary) from emp_nn;
select avg(salary) from emp_nn;
select sum(salary) from emp_nn;
select count(*) from emp_nn;
-- select count(salary) from emp_nn; -- only return count of non null values
select sum(salary),max(salary) from emp_nn;
select count(distinct empname) from emp_nn; -- count of distinct empname 
desc emp_nn;



use bank_sys;
create table emp(empid int auto_increment primary key,empname varchar(20),dept_name varchar(20),salary int);
alter table emp modify empname varchar(20) default 'krushna';
insert into emp(dept_name,salary) values('it',100), ('it',1200),('admin',2000),('admin',1200),('hr',1400),('hr',5000);
select * from emp;


-- group by : creates group of data based on simillar values
select dept_name,min(salary),count(empid) from emp group by dept_name;


select * from placement;

-- count of student
select count(roll_no) from placement;
select count(*) from placement;

-- fetch the list of students having cgpa>5,no backlogs nd have done atleast 1 internship
select * from placement where cgpa>5 and historyofbacklogs=0 and placedornot=1 order by age desc; 
-- count 
select count(*) from placement where cgpa>5 and historyofbacklogs=0 and placedornot=1 order by age desc; 
-- group by branch
select branch,count(*) from placement where cgpa>5 and historyofbacklogs=0 and placedornot=1 group by branch; 
--  how many from these are placed and not for each branch
select branch,placedornot,count(*) from placement where cgpa>5 and historyofbacklogs=0 and internships=1 group by branch,placedornot order by branch;

select branch,placedornot,count(*) from placement where cgpa>5 and historyofbacklogs=0 and internships=1 group by branch,placedornot order by branch limit 1,2; 



-- Having clause :
-- fetch only groups where count of students >100
 select branch,placedornot,count(*) from placement where cgpa>5 and historyofbacklogs=0 and internships=1 group by branch,placedornot having count(*)>=100 order by branch; 
 
 
-- day 5

-- union all :  combine result of two or more select statement
use college1;
select * from emp
union all
select * from student;

select eid from emp
union all
select sid from student;

-- union = combine result of two or more distint select statment(duplicate not allowed) 
select eid from emp
union
select sid from student; -- it delete the sid(1)because it already in eid and give result

insert into student values(1,'krushna','pune');

-- joins : combine the data from multiple tables

-- inner join : common records from both the tables

-- delete from student where sid=1;
select * from student;
select * from course_1;
insert into course_1 values(11,'clanguage',104);
insert into course_1(course_id,course_name) values(12,"java");



select * from student inner join course_1 on student.sid=course_1.s_id;
select sid,sname,course_name,s_id from student inner join course_1 on student.sid=course_1.s_id;
-- select * from course_1 inner join student on student.sid=course_1.s_id;

select student.sid,course_1.s_id,sname,course_id,course_name
from
student 
inner join
course_1
on student.sid=course_1.s_id;

-- left join : inner join + remaining values from left table
-- a left join b : a is the left table and b is the right table
 -- all the record from left tables and matching records from right tables.
 
select student.sid,course_1.s_id,sname,course_id,course_name
from
student 
left join
course_1
on student.sid=course_1.s_id;

-- right join : inner join + remaining values from right table
-- a right join b : a is the left table and b is the right table

select student.sid,course_1.s_id,sname,course_id,course_name
from
student 
right join
course_1
on student.sid=course_1.s_id;

 -- full join : right join union left join(dont take duplicate)
 
 select student.sid,course_1.s_id,sname,course_id,course_name
from
student 
right join
course_1
on student.sid=course_1.s_id
union
select student.sid,course_1.s_id,sname,course_id,course_name
from
student 
left join
course_1
on student.sid=course_1.s_id;

-- examples
select * from employee; 
select emp_id,emp_name,employee.dept_id,dept_name
from
employee
left join 
department
on employee.dept_id=department.dept_id;



select * from employee; 
select emp_id,emp_name,employee.dept_id,dept_name,mgr_name
from
employee
left join 
department
on employee.dept_id=department.dept_id
left join 
manager
on employee.mgr_id = manager.mgr_id; 


select emp_id,emp_name,employee.dept_id,dept_name,mgr_name,proj_name
from
employee
left join 
department
on employee.dept_id=department.dept_id
left join 
manager
on employee.mgr_id = manager.mgr_id
left join
project
on employee.emp_id = project.team_member_id;



use college1;
select * from employee;


select max(salary) from employee;
select * from employee where salary=55000;

-- scalar subqueries : inner query returns a single value
select * from employee where salary=(select max(salary) from employee);

select distinct salary from employee order by salary desc limit 1,1; -- nomral way to fetch 2nd max salary
select salary from employee where salary < (select max(salary) from employee) order by salary desc; -- using scalar subqueris
select max(salary) from employee where salary < (select max(salary) from employee) order by salary desc; -- using scalar subqueris

-- 5th highest salary
select * from employee where salary=
(select distinct salary from employee order by salary desc limit 4,1);

-- average salary of emplyee -- name of employee who's salary is greater than average salary
select emp_name,salary from employee where salary >(
select avg(salary) from employee );


select * from emp_data;
select * from emp_data where  salary > (select avg(salary) from emp_data where dept_id=20) and dept_id=30 ; 

select * from emp_data where 
salary> (select avg(Salary) from emp_data where dept_id=20)
and dept_id=30;


-- day 6

use college1;
select * from employee;

select min(salary) from employee;

-- over () : helping clause 
-- partition by : to define partitons of data
-- order by : to sort the data within partitions

select emp_id,dept_name,salary,salary * 0.25,min(salary) over() from emp; 

select *, 
min(Salary) over (partition by dept_name) from emp;

select *,
min(salary) over (partition by dept_name),
max(salary) over (partition by dept_name) from emp;
select * from emp;


-- row_number() : used to assign an index value or sequence number to each row of the partition
select * from emp;

select *,
row_number() over() as rnumber
from emp;

-- roll number bu dept name
select *,
row_number() over(partition by dept_name) as rnumber
from emp;

select *,
row_number() over(partition by dept_name order by emp_id ) as rnumber
from emp;

select * from (
select *,
row_number() over(partition by dept_name order by emp_id ) as rnumber
from emp) ss
where rnumber<3;

-- rank and dense_rank
-- rank(): used to assign rank values with gaps
-- dense_Rank() : used to assign rank values without gaps
select *,
rank() over(order by salary) as rnumber,
dense_rank() over(order by salary) as densenumber
from emp;


-- lead and lag 
-- lead() : fetch the value from next /preceeding row
-- lag () : fetch the value from previous row

-- lead(column_name,offset,deafult) 

select *,
lead(salary) over() as leadsalary
from emp;

select *,
lead(salary,2) over() as leadsalary
from emp;

select *,
lead(salary,2,0) over() as leadsalary 
from emp; -- null value get 0 value



select *,
lag(salary,2,0) over() as leadsalary
from emp;