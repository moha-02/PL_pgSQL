# PL_pgSQL

## OBJECTIVES 🎯
- Create a project that includes at least
- One function
- One procedure
- One cursor
- One trigger

## Requisites 🛠
- PgAdmin 4 🐘

## PlPgSql definition 🐘
Pl stands for procedual language. In this case PlPgSql  is a procedural programming language supported by the PostgreSQL ORDBMS. It  adds many procedural elements, control structures, loops, and complex computations, to extend standard SQL. This allows us to query and manage the data quite fast, also automatize some functions.

## Project Description 📖

Ouer project emulates a small databes. This contains 2 tables. One of the tables store the data of employees, meanwhile the other table stores the hostory of salarys of each employee. Its a small database to practice the PLPgSql, since everything its built throught procedures. The salary history table its automatized thanks to the trigger which records every change of salary of every employee.

## Script ⚙

### PROCEDURES

The following procedures are in charge of creating the tables and updating, they are easily visible in the PgAdmin GUI, in the SQL file there is the script to genrate them.
![image](https://user-images.githubusercontent.com/119495982/235486102-0fc07c90-93a7-4738-9796-447ab5bbfd64.png)

They can get executed by the following code that it's find in the SQL file
~~~
-- CALL PROCEDURES TO EXECUTE THEM

CALL create_table_employees();
CALL create_table_log_salary();
call create_table_log_salary();
CALL insert_into_employees('Fabian', 'Ossai', 5000.00, 'Manager');
CALL insert_into_employees('Moha', 'Salhi', 8000.00, 'Technician');
~~~

### Triggers
The following trigger and its trigger function allows us to save the current salary of an employe befor it gets updated.They are easily visible in the PgAdmin GUI. It's an automatized function which comes in very handy, in the SQL file there is the script to genrate them.
![image](https://user-images.githubusercontent.com/119495982/235487267-1bc4060c-a90b-439d-903c-d3c696a131d0.png)

### Functions
The following function allows us to calculate the total sum of wages of the moment. This function doesen't have parameters, its set only to be used with the table salary.In the SQL file there is the script to genrate it. Functions  are easily visible in the PgAdmin GUI.
![image](https://user-images.githubusercontent.com/119495982/235487883-47321c81-cc93-4b19-a42e-e9d50b407cf0.png)

It can get executed by 
~~~
-- To execute the function
select sum_column();
~~~

### Cursors
The following cursor filters the employes by salary descending. In ouer case to print all the cursor we used a foor loop. Since we want all the employees not just the first one. There is the alternative with the while loop, but it's easier and shorter with the foor loop metod.In the SQL file there is the script to genrate it.

It can get executed by 
~~~
-- This is a cursor that allows us to order the employees by salary

do $$
declare 
	register Record;
	price_cursor Cursor for select*from employees order by salary desc;
begin

/*	open price_cursor;
	fetch precio_cursor into registro;
	while (FOUND) loop
		Raise Notice 'The neme of the employee is % and employeee id is: % .The salary is : %',registro.name,registro.employee_id,registro.salary;
		fetch precio_cursor into registro;
	end loop;*/ -- THIS CURSOR FETCHES IN THE RECORD USING THE WHILE LOOP TO PRINT FROM THE FIRST TO LAST RECORD
	
-- THE FOR LOOP IS EASIER AND IT'S THE ONE WE ARE GOING TO USE
	for registro in price_cursor loop
	
		Raise Notice 'Employee id: %, employee name: %, employee salary: %', registro.employee_id,registro.name,registro.salary;
		
	end loop;
	
end $$
Language 'plpgsql';
~~~

## Conclusions

To sum up, the PlPgSql is a programing language oriented to managing the database. It makes a lot of repetitive work shorter and faster, also allows to automatize trought triggers. The project helped to practice the mos important parts about plpgsql that makes it very usefull.

## BY 👨‍💻

Mohammed Salhi

Fabian Ossai





