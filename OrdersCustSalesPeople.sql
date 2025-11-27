use employee_department_analysis;
#Q1 - Create the Salespeople as below screenshot.
create table Salespeople(
    snum int primary key,
    sname varchar(100) not null,
    city varchar(100) not null,
    comm decimal(10,2)
);

insert into salespeople values(1001,"PEEL","LONDON",0.12),
                              (1002,"SERRES","SAN JOSE",0.13),
                              (1003,"AXELROD","NEW YORK",0.10),
                              (1004,"MOTIKA","LONDON",0.11),
                              (1007,"RAFKIN","BARCELONA",0.15);

select * from salespeople;

#Q2 - Create the Cust Table as below Screenshot.
create table Cust(
    cnum int primary key,
    cname varchar(100) not null,
    city varchar(100) not null,
    rating int not null,
    snum int not null
);
insert into cust values(2001,"HOFFMAN","LONDON",100,1001),
                       (2002,"GIOVANNE","ROME",200,1003),
                       (2003,"LIU","SAN JOSE",300,1002),
                       (2004,"GRASS","BERLIN",100,1002),
                       (2006,"CLEMENS","LONDON",300,1007),
                       (2007,"PEREIRA","ROME",100,1004),
                       (2008,"JAMES","LONDON",200,1007);
select * from cust;

#Q3 - Create orders table as below screenshot.
create table Orders(
    onum int primary key,
    amt decimal(10,2),
    odate date,
    cnum int not null,
    snum int not null
);
insert into orders values(3001,18.69,"1994-10-03",2008,1007),
                         (3002,1900.10,"1994-10-03",2007,1004),
                         (3003,767.19,"1994-10-03",2001,1001),
                         (3005,5160.45,"1994-10-03",2003,1002),
                         (3006,1098.16,"1994-10-04",2008,1007),
                         (3007,75.75,"1994-10-05",2004,1002),
                         (3008,4723.00,"1994-10-05",2006,1001),
                         (3009,1713.23,"1994-10-04",2002,1003),
                         (3010,1309.95,"1994-10-06",2004,1002),
                         (3011,9891.88,"1994-10-06",2006,1001);
select * from orders;

#Q4 - Write a query to match the salespeople to the customers according to the city they are living.
select s.sname,
       c.cname,
       c.city
from salespeople as s
inner join cust as c
on s.city=c.city;

#Q5 - Write a query to select the names of customers and the salespersons who are providing service to them.
select c.cname as Customer_Name,
       s.sname as Sales_Person
from cust as c
inner join salespeople as s
on c.snum=s.snum;

#Q6 - Write a query to find out all orders by customers not located in the same cities as that of their salespeople
select o.onum as OrderNo,
       o.amt as OrderAmount,
       c.cname as CustomerName,
       c.city as CustomerCity,
       s.sname as SalesPerson,
       s.city as SalesPersonCity
from orders as o
inner join cust as c
on o.cnum=c.cnum
inner join salespeople as s
on o.snum=s.snum
where c.city <> s.city;

#Q7 - Write a query that lists each order number followed by name of customer who made that order
select o.onum as OrderNumber,
       c.cname as CustomerName,
       o.amt as Amount
from orders as o
inner join cust as c
on o.cnum=c.cnum;

#Q8 - Write a query that finds all pairs of customers having the same rating…
select c1.cname as Customer1,
       c2.cname as Customer2,
       c1.rating
from cust as c1
inner join cust as c2
on c1.rating=c2.rating
and c1.cnum < c2.cnum;

#Q9 - Write a query to find out all pairs of customers served by a single salesperson…
select c1.cname as Customer1,
       c2.cname as Customer2,
       s.sname as SalesPerson
from cust as c1
inner join cust as c2
on c1.snum=c2.snum
and c1.cnum < c2.cnum
inner join salespeople as s
on c1.snum=s.snum;

#Q10 - Write a query that produces all pairs of salespeople who are living in same city…
select s1.sname as SalesPerson1,
       s2.sname as SalesPerson2,
       s1.city as City
from salespeople as s1
inner join salespeople as s2
on s1.city = s2.city
and s1.snum < s2.snum;

#Q11 - Write a Query to find all orders credited to the same salesperson who services Customer 2008
select o.onum as OrderNumber,
       o.amt as OrderAmount,
       o.cnum as CustomerNumber,
       o.snum as SalesPersonNumber
from orders as o
where o.snum = (
    select snum
    from cust
    where cnum = 2008
);


#Q12 - Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT *
FROM orders
WHERE odate = '1994-10-04'
  AND amt > (
    SELECT AVG(amt)
    FROM orders
    WHERE odate = '1994-10-04'
);

#Q13 - Write a Query to find all orders attributed to salespeople in London.
select o.onum,
       o.amt,
       o.odate,
       s.sname,
       s.city
from orders as o
inner join salespeople as s
on o.snum = s.snum
where s.city = 'LONDON';

#Q14 - Write a query to find all the customers whose cnum is 1000 above the snum of Serres.
SELECT *
FROM cust
WHERE cnum = (
    SELECT snum + 1000
    FROM salespeople
    WHERE sname = 'Serres'
);


#Q15 - Write a query to count customers with ratings above San Jose’s average rating.
SELECT COUNT(*) AS cust_count
FROM cust
WHERE rating > (
    SELECT AVG(rating)
    FROM cust
    WHERE city = 'SAN JOSE'
);

#Q16 - Write a query to show each salesperson with multiple customers.
SELECT s.snum, s.sname, c.cname
FROM salespeople as s
INNER JOIN cust as c
    ON s.snum = c.snum
WHERE s.snum IN (
    SELECT snum
    FROM cust
    GROUP BY snum
    HAVING COUNT(cnum) > 1
);
