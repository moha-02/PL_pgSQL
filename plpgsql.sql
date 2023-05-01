-- This is a stored procedure that creates the table of employees 

CREATE OR REPLACE PROCEDURE create_table_employees()
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE TABLE employees (
        employee_id SERIAL PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        salary NUMERIC(10,2) NOT NULL,
        occupation VARCHAR(50) NOT NULL
    );
END;
$$;

-- This stored procedure inserts data into the table employee

CREATE OR REPLACE PROCEDURE insert_into_employees(
    p_name VARCHAR(50),
    p_last_name VARCHAR(50),
    p_salary NUMERIC(10,2),
    p_occupation VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employees (name, last_name, salary, occupation)
    VALUES (p_name, p_last_name, p_salary, p_occupation);
END;
$$;

-- This is a stored procedure that creates the table logs

CREATE OR REPLACE PROCEDURE create_table_log_salary()
LANGUAGE plpgsql
AS $$
BEGIN
    CREATE TABLE salary_log (
        employee_id SERIAL,
        salary NUMERIC(10,2) NOT NULL
    );
END;
$$;

--- This is a stored procedure to update the salary of the employees

CREATE OR REPLACE PROCEDURE change_salary(p_id integer,p_salary NUMERIC(10,2))
AS $$
BEGIN
    update employees 
	set salary = p_salary
	where employee_id = p_id; /*The dollar notation allows to pass the second parametter */
END;
$$
LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------
-- CALL PROCEDURES TO EXECUTE THEM

CALL create_table_employees();
CALL create_table_log_salary();
call create_table_log_salary();
CALL insert_into_employees('Fabian', 'Ossai', 5000.00, 'Manager');
CALL insert_into_employees('Moha', 'Salhi', 8000.00, 'Technician');
----------------------------------------------------------------------------------------------------------------
-- This is the trigger function that it will be used

create function trigger_logs() returns Trigger
as
$$
begin
	insert into salary_log values (old.employee_id,old.salary);
	return new;
end $$
Language 'plpgsql';

-- This is the trigger that executes the trigger function

create Trigger salarys_log before Update on employees
for each row
execute procedure trigger_logs();
----------------------------------------------------------------------------------------------------------------
-- This function allows to sum the salary column

CREATE OR REPLACE FUNCTION sum_column()
RETURNS NUMERIC AS $$
DECLARE 
  total NUMERIC;
BEGIN
  SELECT SUM(salary) INTO total FROM employees;
  RETURN total;
END;
$$
LANGUAGE plpgsql;

-- To execute the function
select sum_column();
----------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------

-- HERE WE CAN SEE THE TRIGGER WORKING WITH THE UPDATE SALARY

select*from employees;
call change_salary(1,84562);
select*from employees;
select*from salary_log;
