use hr_database;

SELECT count(employee_id) FROM employees;
select distinct count(employee_id) from employees;
SELECT count(first_name) FROM employees;
select distinct count(first_name) from employees;
SELECT count(last_name) FROM employees;
SELECT distinct count(last_name) FROM employees;
SELECT count(email) FROM employees;
SELECT distinct count(email) FROM employees;
SELECT count(phone_number) FROM employees;
SELECT distinct count(phone_number) FROM employees;
SELECT count(hire_date) FROM employees;
SELECT  distinct count(hire_date) FROM employees;
SELECT count(job_id) FROM employees;
SELECT distinct count(job_id) FROM employees;
SELECT count(salary) FROM employees;
SELECT distinct count(salary) FROM employees;
SELECT count(commission_pct) FROM employees;
SELECT distinct count(commission_pct) FROM employees;
SELECT count(manager_id) FROM employees;
SELECT distinct count(manager_id) FROM employees;
SELECT count(department_id) FROM employees;
SELECT distinct count(department_id) FROM employees;


-- 1. What is the total number of employees?
SELECT count(employee_id) FROM employees;

-- 2. How many departments are present?
select count(distinct department_id) from employees;

-- 3. How many unique job roles are present?
select count(distinct job_id) from employees;

-- 4. What is the average employee salary?
select avg (salary) from employees;

-- 5. What is the median salary?
select me();

-- 6. What are the minimum and maximum salaries?
(select min(salary) as minimum, max(salary) as  maximum from employees);

-- 7. What is the total annual salary expenditure?
select year(hire_date) , sum(salary) as "total salary" 
from employees 
group by year(hire_date)
order by year(hire_date) asc;

-- 8. What percentage of employees receive commission?
select commission_pct from employees
where commission_pct > 0.00;

-- 9. What is the average commission percentage?
select avg(commission_pct) as average from employees
where commission_pct > 0.00; 

-- 10. How many employees report directly to another employee?
select sum(total_employee) from (select manager_id , count(employee_id) as total_employee
from employees group by manager_id) as dd ; 

-- 2. department analysis
-- 1. Calculate employee count by department.
select department_id , count(employee_id) as "total employee" from 
employees group by department_id ;

-- 2. Calculate total salary expenditure by department.
select department_id , sum(salary) as "total salary" from 
employees group by department_id;

-- 3. Calculate average salary by department.
select department_id , avg(salary) as "avg salary" from employees group by department_id;

-- 4. Find the department with the highest employee count.
select department_id , count(employee_id) as "highest employee count" from employees
group by department_id order by count(employee_id) desc limit 1;

-- 5. Find the department with the lowest employee count.
select department_id , count(employee_id) as "highest employee count" from employees
group by department_id order by count(employee_id) asc limit 1;

-- 6. Find the department with the highest average salary.
select department_id , avg(salary) as "highest avg salary" from employees
group by department_id order by avg(salary) desc limit 1;

-- 7. Find the department with the highest total salary expenditure.
select department_id , sum(salary) as "highest total salary " from employees
group by department_id order by sum(salary) desc limit 1;

-- 8. Calculate each department's percentage contribution to total payroll.
select department_id , sum(salary) as "total salary" , (sum(salary)/(select sum(salary) from employees)*100) as payroll from 
employees group by department_id order by sum(salary) desc;
select * from employees;

-- 9. Compare department-wise minimum, average, and maximum salary.
select department_id , min(salary) as minimum , max(salary) as maximum , avg(salary) as average
from employees 
group by department_id;

-- 10. Identify departments where the salary range is highest.
select department_id , max(salary) - min(salary) as highest_range from employees
group by department_id order by highest_range desc limit 1;

-- 3. Salary Analysis
-- 1. Find the top 10 highest-paid employees.
select employee_id , concat(first_name , ' ',last_name ) as employee_name , salary from employees
order by salary desc limit 10;

-- 2. Find the bottom 10 lowest-paid employees.
select employee_id , concat(first_name , ' ',last_name ) as employee_name , salary from employees
order by salary asc limit 10;

-- 3. Find employees earning above the company average.
select avg(salary) from employees;
select employee_id , concat(first_name , ' ',last_name ) as employee_name , salary from employees
where salary > (select avg(salary) from employees);

-- 4. Find employees earning below the company average.
select employee_id , concat(first_name , ' ',last_name ) as employee_name , salary from employees
where salary < (select avg(salary) from employees);

-- 5. Divide employees into salary bands.
select employee_id , concat(first_name , ' ',last_name ) as employee_name  , salary ,
case 
   when salary < 3000 then "low salary"
   when salary > 3001 and salary < 5000 then "midium salary"
   when salary > 5001 and salary < 7000 then "high salary"
   else "very high salary" 
end as "salary band"
from employees
order by salary asc ;

-- 6. Count employees in each salary band.

create view employees_sal_band as
select employee_id , concat(first_name , ' ',last_name ) as employee_name  , salary ,
case 
   when salary < 3000 then "low salary"
   when salary > 3001 and salary < 5000 then "midium salary"
   when salary > 5001 and salary < 7000 then "high salary"
   else "very high salary" 
end as salary_band
from employees
order by salary asc ;


select * from employees_sal_band;
select count(employee_id), salary_band  from employees_sal_band group by salary_band;

-- 7. Calculate the percentage of employees in each salary band.
select salary_band , (count(employee_id)/(select count(employee_id) from employees)*100 ) as percent from employees_sal_band
group by salary_band; 

-- 8. Find the salary difference between the highest- and lowest-paid employee.
select max(salary) - min(salary) as salary from employees;

-- 9. Find the average salary by job role.
select job_id , avg(salary) as avg_salary from employees
group by job_id; 


-- 10. Identify job roles having an average salary above company average.
select job_id, avg(salary) as avg_salary from employees
group by job_id  
having avg(salary) > (select avg(salary) from employees);

-- 4. Job Role Analysis
-- 1. Count employees by job_id.
select job_id,count(employee_id) as total_employee from employees
group by job_id ;

-- 2. Calculate average salary for every job role.
select job_id , avg(salary) as average_salary from employees 
group by job_id ;
  
-- 3. Find the highest-paid job role.
select job_id , max(salary) as highest_paid from employees
group by job_id order by max(salary) desc limit 1 ;

-- 4. Find the lowest-paid job role.
select job_id , min(salary) as lowest_paid from employees
group by job_id order by min(salary) asc limit 1 ;

-- 5. Calculate total payroll by job role.
select job_id , sum(salary) as total_salary from employees
group by job_id  order by total_salary desc ;

-- 6. Find the job role with the largest salary variation.
select job_id , sum(salary) as total_salary from employees
group by job_id  order by total_salary desc limit 1;

-- 7. Identify job roles having only one employee.
select job_id , count(employee_id ) as total_count from employees
group by job_id 
having total_count = 1;

-- 8. Identify job roles with more than 5 employees.
select job_id , count(employee_id ) as total_count from employees
group by job_id 
having total_count > 5;

-- 9. Compare managerial and non-managerial roles.


-- 10. Find the highest-paid employee in each job role.
select  job_id, employee_id , max(salary) as high from employees
group by job_id ,employee_id ; 

-- 5. Manager & Hierarchy Analysis
-- 1. Find the number of employees under each manager.
select manager_id , count(employee_id) from employees
group by manager_id
having manager_id in(select employee_id from employees) ;

-- 2. Find the manager with the largest team.
select manager_id , count(employee_id) from employees
group by manager_id
having manager_id in(select employee_id from employees) 
order by count(employee_id) desc limit 1;

-- 3. Find managers with fewer than 3 direct reports.
select manager_id , count(employee_id) from employees
group by manager_id
having manager_id in(select employee_id from employees) and count(employee_id) < 3;

-- 4. Calculate the average salary of employees reporting to each manager.
select manager_id , avg(employee_id) from employees
group by  manager_id 
having manager_id in (select employee_id from employees);

-- 5. Compare manager salary with the average salary of their team.
