create database employee;
 use employee;
 select * from emp_record_table;
 
 -- Task -3
 select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,Dept from emp_record_table order by dept;
 
-- Task- 4
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, Emp_Rating, 
      case when emp_rating <=2 then 'Low'
      when emp_rating >4 then 'High'
      when emp_rating between 2 and 4 then 'average'
      end as stander 
      from emp_record_table;
 -- Task -5
 select Emp_id, concat(first_name, '',last_name ) Emp_name, Gender, Role, dept from emp_record_table where dept= 'Finance';
 
 -- Task- 6
 
 select m.First_name,count(*) from emp_record_table e join emp_record_table m on e.manager_id = m.emp_id group by m.First_name;
 
 
 -- task -7
 
 select * from emp_record_table where dept = 'healthcare'
 union
 select * from emp_record_table where dept ='Finance';
 
 
 -- Task -8 
 
 select emp_id, First_name, Last_name, role, dept, emp_rating, 
       max(emp_rating) over(partition by dept) Max_rating from emp_record_table;
       
-- Task-9
select role, min(salary), max(salary) from emp_record_table group by role;

-- Task -10

select *, rank() over(order by exp desc) Rank_exp from emp_record_table;

-- Task-11

CREATE VIEW Vw_Emp_SalaryAbove6k
as
select EMP_ID,FIRST_NAME,LAST_NAME,SALARY,COUNTRY
	from emp_record_table
	where SALARY > 6000
    order by COUNTRY;
select * from Vw_Emp_SalaryAbove6k;


-- Task -12 

select * from emp_record_table where emp_id in (select emp_id from emp_record_table where exp > 10 );


-- task-13

USE `employee`;
DROP procedure IF EXISTS `emp_exp2`;

DELIMITER $$
USE `employee`$$
CREATE PROCEDURE emp_exp2 ()
BEGIN
select * from emp_record_table where exp > 3;
END$$

DELIMITER ;

call emp_exp2;


-- task-14


DELIMITER $$
USE `employee`$$
CREATE FUNCTION Check_JobProfiles (eid   char(4)) 
RETURNS varchar(100) 
    DETERMINISTIC
BEGIN
	declare ex int;
    declare r varchar(80);
    declare vrole varchar(100);
    declare flag varchar(10);
    select exp, ROLE into ex, VROLE from data_science_team where emp_ID = eid;
  
		if ex > 12 and ex < 16 then
			if VROLE = 'Manager' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			# set r = 'Manager';
		elseif ex > 10 and ex <= 12 then 
			if VROLE = 'LEAD DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'LEAD DATA SCIENTIST';
		elseif ex > 5 and ex <=10 then 
			if VROLE = 'SENIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;

		elseif ex > 2 and ex <=5 then
			if VROLE = 'ASSOCIATE DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'ASSOCIATE DATA SCIENTIST';
		elseif ex <= 2 then
			if VROLE = 'JUNIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
		end if;
	RETURN flag;
END$$
DELIMITER ;
;

SELECT *,Check_JobProfiles(Emp_ID) as Standard FROM data_science_team;


-- Task -15 

select * from emp_record_table where FIRST_NAME = 'Eric';

CREATE INDEX IDX_FirstName on emp_record_table(FIRST_NAME);

select * from emp_record_table where FIRST_NAME = 'Eric';


-- task 16 

select EMP_ID,FIRST_NAME,LAST_NAME,SALARY,EMP_RATING,
	(SALARY * .05) * EMP_RATING as Bonus
	from emp_record_table;
    
-- Task -17

select CONTINENT,COUNTRY,Avg(Salary) 
	from emp_record_table 
	group by CONTINENT,COUNTRY with rollup;
