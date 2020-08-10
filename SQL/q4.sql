-- i wrote this, which clearly did same duplicate work
select ((premiered / 10) * 10) || "s", count((premiered / 10) * 10)
from titles where (premiered/10) * 10 in 
(SELECT ( premiered / 10) * 10 as decade from titles WHERE decade!=0 ORDER BY decade) 
GROUP by (premiered /10) * 10 
ORDER by count((premiered / 10) * 10);


-- as decade can by calculated so it surely can be used in group by
SELECT (premiered / 10 * 10) || "s"  as decade, 
count(*) as num_movies
from titles 
where premiered is NOT null
GROUP by decade
order by num_movies;
