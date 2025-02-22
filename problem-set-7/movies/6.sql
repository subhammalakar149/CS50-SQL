-- determine the average rating of all movies released in 2012

select avg(b.rating) avg_rating
from
    movies a,
    ratings b
where
    a.id = b.movie_id
    and a.year = '2012';
