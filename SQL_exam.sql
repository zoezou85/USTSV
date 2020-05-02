# 1. Employees all over the world. Can you tell me the top three cities that we have employees?
SELECT classicmodels.offices.city
FROM (select officeCode 
		from classicmodels.employees e
		group by officeCode
        order by count(employeeNumber) desc) b 
left join offices
on b.officeCode=offices.officeCode
limit 3;

# 2. For company products, each product has inventory and buy price, msrp.
# Assume that every product is sold on msrp price. Can you write a query to 
# tell company executives: profit margin on each productlines
SELECT productLine, sum((MSRP-buyPrice)*quantityInStock) as ProfitMargin
 FROM classicmodels.products
 group by productLine
 order by ProfitMargin desc;

# 3. company wants to award the top 3 sales rep They look at who produces the most sales revenue.
# A.can you write a query to help find the employees. 
Select a.salesRepEmployeeNumber 
from classicmodels.customers a
left join (SELECT *, sum(amount) as expense
 FROM classicmodels.payments
 group by customerNumber) as c
 on c.customerNumber=a.customerNumber
group by a.salesRepEmployeeNumber
order by sum(expense) desc
limit 3;
# B.if we want to promote the employee to a manager,
# what do you think are the tables to be updated
# answer: employees
# C. An employee is leaving the company, write a stored procedure to handle the case. 
# 1).Make the current employee inactive
# 2) Replaced with its manager employeenumber in order table. 

# 4. Employee Salary Change Times 
# Ask to provide a table to show for each employee in a certain department how many times 
# their Salary changes 
Select department_name, b.*
From 
(Select employee_id, employee_name, count(salary)
From employee e left join employee_salary s
On e.employee_id=s.employee_id
Group by year,month) as b
Left join department
On b.department_id=department.department_id
where department_name='?';

#5. Ask to provide a table to show for each department the top 3 salary with employee name 
# and employee has not left the company.
Select employee_name , current_salary, dense_rank() over (Partition by department_id Order by current_salary desc) as rank_salary
From employee e left join department d
On e.department_id=d.department_id
Where rank_salary<=3 and term_date is null;






;
