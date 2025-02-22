-- determine the number of movies with an IMDb rating of 10.0

select count(a.id) as movie_count
from
    movies a,
    ratings b
where
    a.id = b.movie_id
    and b.rating = '10.0';
