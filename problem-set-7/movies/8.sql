-- list the names of all people who starred in Toy Story

select
    name
from
    people
where id in (select person_id from stars where movie_id = '114709'); -- movie_id belongs to Toy Story
