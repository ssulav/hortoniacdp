select lpad(zipcode,5,"0"), avg((weight*4500/(height*height))) as bmi from hortoniabank.us_customers group by lpad(zipcode,5,"0")
