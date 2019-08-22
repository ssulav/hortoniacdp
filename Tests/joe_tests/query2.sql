select * from (select state, avg((weight*4500/(height*height))) as bmi from hortoniabank.us_customers group by state) s order by bmi desc limit 5
