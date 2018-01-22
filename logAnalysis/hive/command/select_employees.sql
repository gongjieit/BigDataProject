--select the employees whom Federal Taxes over 0.2
select name,deductions['Federal Taxes'] from employees
where deductions['Federal Taxes'] > 0.2;

SELECT name,deductions['Federal Taxes'] from employees
where deductions['Federal Taxes'] > cast(0.2 as FLOAT );

select name,deductions['Federal Taxes'] from employees
where deductions['Federal Taxes'] > 0.2+1e-5;


--select the name of the manager, which second subordinate is Todd Jones
select name from employees
where subordinates[1] = 'Todd Jones';

--who is manager
select name from employees
where size(subordinates) > 0;

--who live in there, where address zip code is 60500
select name from employees
where address.zip=60500;

--who live in that city which name start with letter C
select name,address from employees
where address.city like 'C%';

--who live in Ontario or Chicago street
select name,address from employees
where address.street RLIKE '^.*(Ontario|Chicago).*$';
