-- ===============================
-- TASK 1 Database Design
-- ===============================


-- ===============================
-- creating database HMBank
-- ===============================
create database HMBank;

-- ===============================
-- creating table customers
-- ===============================
create table customers (customer_id int primary key auto_increment,
 first_name varchar(30) not null,
 last_name varchar(30) not null,
 DOB date,
 email varchar(40) unique not null,
 phone_number varchar(20),
 address text
 );

-- ===============================
-- creating table accounts
-- ===============================
account_id int primary key auto_increment,
customer_id int not null,
account_type enum('savings', 'current', 'zero_balance') not null,
balance decimal(15, 2) not null default 0.00,
foreign key (customer_id) references customers(customer_id) on delete cascade,
constraint chk_balance check (balance >= 0)
);

-- ===============================
-- creating table transactions
-- ===============================
create table transactions ( transaction_id int primary key auto_increment, account_id int not
null,
 -> transaction_type enum('deposit', 'withdrawal', 'transfer') not null, amount decimal(15,2)
not null,
 -> transaction_date datetime not null default current_timestamp,
 -> foreign key (account_id) references accounts(account_id) on delete cascade,constraint
chk_amount check (amount>0));


-- ===============================
-- Tasks 2: Select, Where, Between, AND, LIKE:
-- ===============================

-- ===============================
-- insert values into customers table
-- ===============================
insert into customers (first_name, last_name, DOB, email, phone_number, address)
values('Ibrahim','Sheriff','2000-01-01','sheriff@gmail.com','+91-1234567890','123 main
madurai'),
('Hari','Sudhan','2002-06-07','haris@gmail.com','+91-7865458965','12 west madurai'),
('Sheryl','Madina','1999-04-23','madinasheryl@gmail.com','+91-7854278546','123 main
coimbatore'),
('Umar','Sheriff','1979-04-23','umar@gmail.com','+91-8627496874','74 east madurai'),
('David','Westly','1981-09-12','wdavid@gmail.com','+91-9834765430','11 cross street
chennai'),
('Margeret','Stones','1997-11-06','mstone@gmail.com','+91-8753685935','10 main trichy'),
('Mohan','Prasath','2001-09-12','prasath@gmail.com','+91-9876543210','107 simakkal
madurai'),
('Fasila','Wahed','1991-10-10','wahedfasila@gmail.com','+91-8976548576','31 main
banglore'),
('Mahath','Mithun','2000-12-19','mahathmithun@gmail.com','+91-7865436786','89 eggmore
chennai'),
('Sanjay','Kanna','2003-08-29','skanna@gmail.com','+91-9878987898','45 west
thiruvananthapuram');


-- ===============================
-- insert values into accounts table
-- ===============================
insert into accounts (customer_id, account_type, balance) values
(1,'savings',8000.00),
(1,'current',2000),
(2,'savings',6000),
(3,'zero_balance',0.00),
(4,'current',3000),
(5,'savings',5000),
(6,'zero_balance',0.00),
(7,'savings',700),
(8,'current',7000),
(9,'savings',4000);



-- ===============================
-- insert values into transactions table
-- ===============================
insert into transactions (account_id, transaction_type, amount, transaction_date) values
(1,'withdrawal',2000,'2025-01-01 10:00:00'),
 -> (2,'deposit',3000,'2025-01-02 11:00:00'),
 -> (3,'deposit',3000,'2025-01-03 12:00:00'),
 -> (4,'deposit',7000,'2025-01-04 13:00:00'),
 -> (5,'withdrawal',1000,'2025-01-05 14:00:00'),
 -> (6,'withdrawal',2000,'2025-01-06 15:00:00'),
 -> (7,'deposit',500,'2025-01-07 16:00:00'),
 -> (8,'transfer',300,'2025-01-08 17:00:00'),
 -> (9,'deposit',1000,'2025-01-01 10:00:00'),
 -> (10,'withdrawal',3000,'2025-01-10 19:00:00');


-- 1. Write a SQL query to retrieve the name, account type and email of all customers.
select first_name, last_name, account_type, email from customers, accounts where
customers.customer_id = accounts.customer_id;

-- 2. Write a SQL query to list all transaction corresponding customer.
select transactions.* from customers, accounts, transactions where customers.customer_id =
accounts.customer_id and accounts.account_id = transactions.account_id;

-- 3. Write a SQL query to increase the balance of a specific account by a certain amount.
Update accounts set balance = balance + 20000 where account_id = 2;

-- 4. Write a SQL query to Combine first and last names of customers as a full_name.
select concat(first_name,' ',last_name) from customers as full_name;

-- 5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
delete from accounts where balance<1;

-- 6. Write a SQL query to Find customers living in a specific city.
select * from customers where address like '%madurai%';

-- 7. Write a SQL query to Get the account balance for a specific account.
select balance from accounts where account_id = 1;

-- 8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select * from accounts where account_type = 'current' and balance> 1000;

-- 9. Write a SQL query to Retrieve all transactions for a specific account.
select * from transactions where account_id = 1;

-- 10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
select account_id, balance * 0.05 as interest from accounts where account_type = 'savings';

-- 11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
select * from accounts where balance <5000;

-- 12. Write a SQL query to Find customers not living in a specific city.
select * from customers where address not like '%madurai%';



-- ===============================
-- Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:
-- ===============================

-- 1. Write a SQL query to Find the average account balance for all customers.
select avg(balance) as avg_balance from accounts;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
select account_id, balance from accounts order by balance desc;

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select sum(amount) as total_deposits from transactions where transaction_date = '2025-01-01
10:00:00' and transaction_type = 'deposit';

-- 4. Write a SQL query to Find the Oldest and Newest Customers.
(select first_name, last_name, DOB, 'oldest' as old_or_new from customers where dob =
(select min(dob) from customers)) union (select first_name, last_name, DOB, 'newest' as
old_or_new from customers where dob = (select max(dob) from customers));

-- 5. Write a SQL query to Retrieve transaction details along with the account type.
select t.*, a.account_type from transactions t, accounts a where t.account_id = a.account_id;

-- 6. Write a SQL query to Get a list of customers along with their account details.
select c.first_name, c.last_name, a.account_id, a.account_type, a.balance from customers c,
accounts a where c.customer_id = a.customer_id order by account_type;

-- 7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
select a.account_id, count(t.transaction_id) from accounts a,transactions t where a.account_id
= t.account_id and a.account_id = 1 group by a.account_id;

-- 8. Write a SQL query to Identify customers who have more than one account.
select c.*, count(a.account_id) as count_of_acc from customers c join accounts a on
c.customer_id = a.customer_id group by c.customer_id having count(a.account_id)>1 ;

-- 9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
select sum(case when transaction_type = 'deposit' then amount else 0 end) as total_deposit ,
sum(case when transaction_type='withdrawal' then amount else 0 end) as total_withdrawal,
sum(case when transaction_type = 'deposit' then amo nt else 0 end) - sum(case when
transaction_type='withdrawal' then amount else 0 end) as difference from transactions ;

-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
select a.account_id, avg(a.balance) as average from accounts a, transactions where
transaction_date between '2025-01-01 10:00:00' and '2025-01-10 19:00:00' group by
a.account_id;

-- 11. Calculate the total balance for each account type.
select account_type, sum(balance) as total_balance from accounts group by account_type;

-- 12. Identify accounts with the highest number of transactions order by descending order.
select account_id, count(*) as total_count from transactions group by account_id order by
total_count desc;

-- 13. List customers with high aggregate account balances, along with their account types.
select c.first_name, c.last_name, a.account_type, sum(a.balance) as total_balance from
customers c, accounts a where c.customer_id = a.customer_id group by a.account_id having
sum(a.balance)>5000;

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account
select t.account_id, t.amount, t.transaction_date, count(*) as duplicate_count from
transactions t group by t.account_id, t.amount, t.transaction_date having count(*)>1;



-- ===============================
--Tasks 4: Subquery and its type:
-- ===============================

--Accounts table updated : (updated to use branch_id)
alter table accounts add branch_id int;

--1. Retrieve the customer(s) with the highest account balance.
select c.customer_id, c.first_name, c.last_name, a.account_type, a.balance from customers c,
accounts a where c.customer_id = a.customer_id and balance = (select max(balance) from
accounts);

-- 2. Calculate the average account balance for customers who have more than one account.
select avg(balance) as avg_balance from accounts where customer_id in (select customer_id
from accounts group by customer_id having count(*)>1);

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select * from transactions t where t.amount > (select avg(t.amount) from transactions t);

-- 4. Identify customers who have no recorded transactions.
select c.* from customers c where customer_id not in (select a.customer_id from accounts a
join transactions t on a.account_id = t.account_id);

-- 5. Calculate the total balance of accounts with no recorded transactions.
select sum(balance) as total_balance from accounts where account_id not in(select distinct
account_id from transactions);

-- 6. Retrieve transactions for accounts with the lowest balance.
select * from transactions where account_id in(select account_id from accounts where
balance = (select min(balance) from accounts));

-- 7. Identify customers who have accounts of multiple types.
select customer_id, first_name, last_name from customers where customer_id = (select
customer_id from accounts group by customer_id having count(distinct account_type)>1);

-- 8. Calculate the percentage of each account type out of the total number of accounts.
select count(*) * 100 / (select count(*) from accounts) as percentage from accounts group by
account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id.
select * from transactions where account_id in(select account_id from accounts where
customer_id = 1);

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
select distinct account_type,(select sum(balance) from accounts as a2 where a2.account_type
= a1.account_type) as total_balance from accounts a1;
