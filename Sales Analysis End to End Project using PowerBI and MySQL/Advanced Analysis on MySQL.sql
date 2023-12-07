
-- Advanced Analysis On MySQL:
-- Q1. Total Revenue ad sales generated over the years

select year(o.orderDate) as years,sum(od.quantityOrdered*od.priceEach) as revenue,
count(od.orderNumber) as no_of_orders from orderdetails od join orders o on od.orderNumber=o.orderNumber
group by 1;

-- Q2. Total Sales by subcategory 
select * , round((sales2004-sales2003)*100/sales2004,1) 'growth 2003-2004(%)',
round((sales2005-sales2004)*100/sales2005,1) 'growth 2004-2005(%)'
from
(select p.productLine,
sum(if (year(o.orderDate)=2003,od.quantityOrdered*od.priceEach,0)) sales2003,
sum(if (year(o.orderDate)=2004,od.quantityOrdered*od.priceEach,0)) sales2004,
sum(if (year(o.orderDate)=2005,od.quantityOrdered*od.priceEach,0)) sales2005
from orders o join orderdetails od on o.orderNumber=od.orderNumber join products p on p.productCode=od.productCode
group by 1) sales;

-- Q3. Total customer transaction over years

select year(orderDate) 'Year', count(p.customerNumber) 'Total Transactions'
from orders o join payments p 
on o.customerNumber=p.customerNumber
group by 1;
 
-- Q4. New customers over the years

select year(first_order) 'Year',count(cn) 'New Customers' from
(select customerNumber cn,min(orderDate) first_order 
from orders
group by 1) f
group by 1;
