-- list the titles of the five highest rated movies (in order) that Chadwick Boseman starred in, starting with the highest rated.

select
    a.title as movie_name
from
    movies a,
    ratings b
where
    a.id = b.movie_id
    and a.id in (select movie_id from stars where person_id in (select id from people where name = 'Chadwick Boseman'))
order by
    b.rating desc
limit 5;
