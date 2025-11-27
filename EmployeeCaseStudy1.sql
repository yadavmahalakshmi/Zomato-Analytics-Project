create database	Employee_Department_Analysis;
use Employee_Department_Analysis;

#Q1 - Create the Employee table as per the below data provided
create table Dept(
    deptno int primary key,
    dname varchar(100),
    loc varchar(100)
);
describe Dept;
create table Employee(
    empno int primary key,
    ename varchar(100),
    job varchar(100) default 'CLERK',
    mgr int,
    hiredate date,
    sal decimal(10,2) check(sal > 0),
    comm decimal(10,2),
    deptno int,
    foreign key(deptno) references Dept(deptno)
);
describe Employee;

insert into Employee(empno,ename,mgr,hiredate,sal,comm,deptno) values(7369,"SMITH",7902,"1890-12-17",800.00,NULL,20);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600.00,300.00,30);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7521,"WARD","SALESMAN",7698,"1981-02-22",1250.00,500.00,30);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7566,"JONES","MANAGER",7839,"1981-04-02",2975.00,NULL,20);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7654,"MARTIN","SALESMAN",7698,"1981-09-28",1250.00,1400.00,30);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7698,"BLAKE","MANAGER",7839,"1981-05-01",2850.00,NULL,30);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7782,"CLARK","MANAGER",7839,"1981-06-09",2450.00,NULL,10);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7788,"SCOTT","ANALYST",7566,"1987-04-19",3000.00,NULL,20);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7839,"KING","PRESIDENT",NULL,"1981-11-17",5000.00,NULL,10);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7844,"TURNER","SALESMAN",7698,"1981-09-08",1500.00,0.00,30);
insert into Employee(empno,ename,mgr,hiredate,sal,comm,deptno) values(7876,"ADAMS",7788,"1987-05-23",1100.00,NULL,20);
insert into Employee(empno,ename,mgr,hiredate,sal,comm,deptno) values(7900,"JAMES",7698,"1981-12-03",950.00,NULL,30);
insert into Employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values(7902,"FORD","ANALYST",7566,"1981-12-03",3000.00,NULL,20);
insert into Employee(empno,ename,mgr,hiredate,sal,comm,deptno) values(7934,"MILLER",7782,"1982-01-23",1300.00,NULL,10);
select * from Employee;

#Q2 - Create the Dept table as below
insert into Dept values(10,"OPERATIONS","BOSTON"),
					   (20,"RESEARCH","DALLAS"),
                       (30,"SALES","CHICAGO"),
                       (40,"ACCOUNTING","NEW YORK");
select * from Dept;


#Q3 - List the Names and salary of the employee whose salary is greater than 1000
select ename,sal from Employee where sal > 1000 order by sal desc;


#Q4 - List the details of the employees who have joined before end of September 81.
select * from Employee where hiredate < "1981-09-30" order by hiredate;



#Q5 - List Employee Names having I as second character.
select ename from Employee where ename like ('_I%');



#Q6 - List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns
select ename as Employee_Name,
       sal as Basic_Salary,
       (sal * 0.40) as Allowances,
       (sal * 0.10) as Provident_Fund,
       (sal + (sal * 0.40) - (sal * 0.10)) as Net_Salary
from Employee
order by Basic_Salary desc;



#Q7 - List Employee Names with designations who does not report to anybody
select ename as Employee_Name,
       job as Designation
from Employee
where mgr is null;



#Q8 - List Empno, Ename and Salary in the ascending order of salary.
select empno,ename,sal from employee order by sal asc;



#Q9 - How many jobs are available in the Organization ?
select count(distinct job) as Jobs_Available from Employee;



#Q10 - Determine total payable salary of salesman category
select sum(sal) as Total_Payable_Salary from employee where job='SALESMAN';



#Q11 - List average monthly salary for each job within each department
select d.dname,
       e.job,
       avg(e.sal) as Average_Salary
from employee e
inner join dept d
on e.deptno = d.deptno
group by d.dname, e.job
order by d.dname, e.job;


#Q12 - Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
select e.ename,
       d.dname,
       e.sal
from employee as e
inner join dept as d
on e.deptno=d.deptno;


#Q13 - Create the Job Grades Table as below
create table Job_Grades(
    grade varchar(50),
    lowest_sal int not null,
    highest_sal int not null
);

insert into Job_Grades values("A",0,999),
                             ("B",1000,1999),
                             ("C",2000,2999),
                             ("D",3000,3999),
                             ("E",4000,5000);
select * from job_grades;


#Q14 - Display the last name, salary and  Corresponding Grade.
select e.ename as Employee_Name,
       e.sal as Salary,
       j.grade as Grade
from employee e
inner join Job_Grades j
on e.sal between j.lowest_sal and j.highest_sal
order by e.ename;



#Q15 - Display the Emp name and the Manager name under whom the Employee works in the below format .
#Emp Report to Mgr.
select e.ename as Employee_Name,
       coalesce(m.ename,"NO MANAGER") as Manager_Name
from employee e
left join employee m
on e.mgr = m.empno
order by e.ename;


#Q16 - Display Empname and Total sal where Total Sal (sal + Comm)
select ename,
       (sal + coalesce(comm, 0)) as Total_Salary
from employee
order by sal desc;

#Q17 - Display Empname and Sal whose empno is a odd number
select ename,
       sal
from employee
where mod(empno, 2) = 1;


#Q18 - Display Empname , Rank of sal in Organisation , Rank of Sal in their department
select ename,
       sal,
       rank() over (order by sal desc) as Org_Sal_Rank,
       rank() over (partition by deptno order by sal desc) as Dept_Sal_Rank
from employee
order by sal desc;

#Q19 - Display Top 3 Empnames based on their Salary
select ename, sal
from employee
order by sal desc
limit 3;

#Q20 - Display Empname who has highest Salary in Each Department.
select ename,
       sal,
       deptno
from (
    select ename,
           sal,
           deptno,
           rank() over(partition by deptno order by sal desc) as Sal_Rank
    from employee
) t
where Sal_Rank = 1
order by deptno;
