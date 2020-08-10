/*
q2
List the longest title of each type along with the runtime minutes.
Details: Find the titles which are the longest by runtime minutes. 
There might be cases where there is a tie for the longest titles - in that case return all of them. 
Display the types, primary titles and runtime minutes, and order it according to type (ascending) and use primary titles (ascending) as tie-breaker.
 */
-- with return a table, and name the col as table(col_name1, col_name2)
WITH types(type, runtime_minutes) AS ( 
  SELECT type, MAX(runtime_minutes)
    FROM titles
    GROUP BY type
)
SELECT titles.type, titles.primary_title, titles.runtime_minutes
  FROM titles
  JOIN types
  ON titles.runtime_minutes == types.runtime_minutes AND titles.type == types.type
  ORDER BY titles.type, titles.primary_title
  ;


/*
q3
List all types of titles along with the number of associated titles
 */
select 
	type, count(type) 
	from titles 
	GROUP by type 
	order by count(type) ASC
;


-- as decade can by calculated so it surely can be used in group by
/*
q4
Which decades saw the most number of titles getting premiered? List the number of titles in every decade. Like 2010s|2789741.
*/
SELECT (premiered / 10 * 10) || "s"  as decade, 
count(*) as num_movies
from titles 
where premiered is NOT null
GROUP by decade
order by num_movies
;



/*
q5
List the decades and the percentage of titles which premiered in the corresponding decade. Display like : 2010s|45.7042
1. nested select can be implemented at any place
2. group by decade which calculated at the beginning of the selection
 */
select
	cast(premiered / 10 * 10 as TEXT) || 's' as decade,
	round(cast(count(*) as real) / (select count(*) from titles) * 100.0, 4) as percentage
	from titles
	where premiered is not null
	group by decade
	order by percentage desc, decade asc
;
