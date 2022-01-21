# Lab | Aggregation Revisited - Sub queries


#Write the SQL queries to answer the following questions:

 # - Select the first name, last name, and email address of all the customers who have rented a movie.
 
 select * from sakila.rental;
 select first_name, last_name, email from sakila.customer right join sakila.rental using (customer_id);
 select * from sakila.customer c
 where c.customer_id in (select customer_id from sakila.rental);
 
 # Answer: With the subquery it lists the name and email of the customer only once! With the first query
 # it lists them as many times as the customer has rented a movie.
 
 # - What is the average payment made by each customer (display the *customer id*, *customer name* 
 # (concatenated), and the *average payment made*).
 
 select c.customer_id , concat (first_name ,' ',last_name) as customer_name, avg(amount)  
 from sakila.payment join sakila.customer c
 group by customer_id;


 # - Select the *name* and *email* address of all the customers who have rented the "Action" movies.
select concat(first_name, ' ', last_name) as customer_name , email, name from sakila.customer join
sakila.rental using (customer_id) join sakila.inventory using(inventory_id) 
join sakila.film_category using (film_id) join sakila.category c using (category_id)
where name = 'Action';
select * from sakila.film_category;

select concat(first_name,' ', last_name) as customer_name, email from sakila.customer where customer_id in
(select customer_id from sakila.rental where inventory_id in
(select inventory_id from sakila.inventory 
where film_id in (
select film_id from sakila.film_category where category_id in 
(select category_id from sakila.category where name='Action') ) ));

#    - Write the query using multiple join statements
 #   - Write the query using sub queries with multiple WHERE clause and `IN` condition
  #  - Verify if the above two queries produce the same results or not

  #- Use the case statement to create a new column classifying existing columns as either or high value 
  #transactions based on the amount of payment. If the amount is between 0 and 2, label should be `low` and 
  #if the amount is between 2 and 4, the label should be `medium`, and if it is more than 4, then it should 
  #be `high`.

select * ,
case 
when amount >=0 and amount <2 then 'low'
when amount >=2 and amount <4 then 'medium'
when amount >= 4 then  'high'
end as amount_classification
from sakila.payment;