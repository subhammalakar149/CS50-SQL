-- list all movies released in 2010 and their ratings, in descending order by rating. For movies with the same rating, order them alphabetically by title.
select
    a.title as movie_name,
    b.rating
from
    movies a,
    ratings b
where
    a.id = b.movie_id
    and a.year = '2010'
    and b.rating >= 1
order by
    b.rating desc,
    a.title asc;
