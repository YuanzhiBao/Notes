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
-- Non-aggregated values in SELECT output clause must appear in GROUP BY clause.
-- Means only select group by clause
-- Which can filter by HAVING keyword

/*
q6
Count the number of titles in akas for each title in the titles table, and list only the top ten.
 */
-- implied there is duplicate title_id in the table. I missed this important info.

.print "\n*********output from TA'ssolution*******\n"

WITH translations AS (
  SELECT title_id, count(*) as num_translations
    FROM akas
    GROUP BY title_id
    ORDER BY num_translations DESC, title_id
    LIMIT 10
)
SELECT titles.primary_title, translations.num_translations
  FROM translations
  JOIN titles
  ON titles.title_id == translations.title_id
  ORDER BY translations.num_translations DESC
  ;


.print "\n*********output from second solution*******\n"

-- second solution by baoyuanzhi which is not need join function

WITH translations AS (
  SELECT title_id, count(*) as num_translations
    FROM akas
    GROUP BY title_id
    ORDER BY num_translations DESC, title_id
    LIMIT 10
)
select t.primary_title, translations.num_translations
from titles as t, translations
where t.title_id == translations.title_id
;

/*
q7
List the IMDB Top 250 movies along with its weighted rating.
Details: The weighted rating of a movie is calculated according to the following formula:

Weighted rating (WR) = (v/(v+m)) * R + (m/(v+m)) * C

- R = average rating for the movie (mean), i.e. ratings.rating
- v = number of votes for the movie, i.e. ratings.votes
- m = minimum votes required to be listed in the Top 250 (current 25000)
- C = weighted average rating of all movies
Print the movie name along with its weighted rating. For example: The Shawshank Redemption|9.27408375213064.
 */

.print "\n*********output from TA's solution*******\n"

-- with means you created a temp table

WITH
  av(average_rating) AS (
    SELECT SUM(rating * votes) / SUM(votes)
      FROM ratings
      JOIN titles
      ON titles.title_id == ratings.title_id AND titles.type == "movie" 
  ),
  mn(min_rating) AS (SELECT 25000.0)
SELECT
  primary_title,
  (votes / (votes + min_rating)) * rating + (min_rating / (votes + min_rating)) * average_rating as weighed_rating
  FROM ratings, av, mn
  JOIN titles
  ON titles.title_id == ratings.title_id and titles.type == "movie"
  ORDER BY weighed_rating DESC
  LIMIT 250
  ;

/*
q10
List all distinct genres and the number of titles associated with them.
*/

-- q10_test, recursive
-- recursive must has two selects. and union/ union all combine them
-- first select is a inital statement, second is the recursive part
-- the name of the recursive must appear only once after the second select
-- there must be the end statement as where in this example

with recursive split (rest) as
(
		select genres || ',' from titles where title_id = "tt0000042"
		union all
		select
			substr(rest, 0, instr(rest, ','))
		from split
		where rest != ''

)
select * from split;
