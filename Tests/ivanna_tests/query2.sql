select * from (select countryfull, count(*) num_customers from hortoniabank.ww_customers group by countryfull) s order by num_customers desc limit 5
