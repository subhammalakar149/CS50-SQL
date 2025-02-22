-- ist the names of all people who have directed a movie that received a rating of at least 9.0

select
    distinct(name)
from
    people
where
    id in
        (select
            person_id
        from
            directors
        where
            movie_id in
                        (select
                            a.id
                        from
                            movies a,
                            ratings b
                        where
                            a.id = b.movie_id
                            and b.rating >= '9.0'));
