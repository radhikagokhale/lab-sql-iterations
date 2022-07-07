-- 1.Write a query to find what is the total business done by each store.

select count(payment_id) from payment a
join staff b on a.staff_id = b.staff_id
where b.store_id = 1;

-- 2. Convert the previous query into a stored procedure.

 DELIMITER //
create procedure store_total_sales() 
begin
select count(payment_id) from payment a
join staff b on a.staff_id = b.staff_id
where b.store_id = 1;
 end //
DELIMITER ;

-- 3.Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

 DELIMITER //
create procedure store_total_sales(in param int) 
begin
select count(payment_id) from payment a
join staff b on a.staff_id = b.staff_id
where b.store_id = param;
 end //
DELIMITER ;

call store_total_sales(2);

-- 4.Update the previous query.
-- Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store).
-- Call the stored procedure and print the results.

 DELIMITER //
create procedure store_total_sales(in param int) 
begin
declare total_sales_value float;

select count(payment_id) into total_sales_value from payment a
join staff b on a.staff_id = b.staff_id
where b.store_id = param;
 end //
DELIMITER ;

call store_total_sales(2, @total_sales_value);

-- In the previous query, add another variable flag. If the total sales value for the store is over 30.000,
-- then label it as green_flag, otherwise label is as red_flag.
-- Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.

 DELIMITER //
create procedure store_total_sales(in param int) 
begin
declare total_sales_value float;
declare flag varchar(20) default "";

select count(payment_id) into total_sales_value from payment a
join staff b on a.staff_id = b.staff_id
where b.store_id = param;

if total_sales_value >= 30000 then
	set flag = 'Green Flag';
elseif total_sales_value < 30000 then
    set flag = 'Red Flag';
end if;

select flag;
 end //
DELIMITER ;

call store_total_sales(1);