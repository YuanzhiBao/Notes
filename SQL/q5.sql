select th , ROUND(c*1.0 / (select count(type) as h from titles)*1.0, 4) * 100 
from ( select ((premiered / 10) * 10) || "s" as th, count((premiered / 10) * 10) as c 
		from titles where (premiered/10) * 10 in 
		(SELECT (premiered / 10) * 10 as decade from titles WHERE decade!=0 ORDER BY decade) 
		GROUP by (premiered /10) * 10 
		ORDER by count((premiered / 10) * 10));


-- modified
select th , ROUND(c*1.0 / (select count(*) as h from titles)*1.0, 4) * 100 
from (select ((premiered / 10) * 10) || "s" as th, count((premiered / 10) * 10) as c 
		from titles where premiered is not null
		group by th
		ORDER by c);


-- modified from solution
select
	cast(premiered / 10 * 10 as TEXT) || 's' as decade,
	round(cast(count(*) as real) / (select count(*) from titles) * 100.0, 4) as percentage
	from titles
	where premiered is not null
	group by decade
	order by percentage desc, decade asc
;
