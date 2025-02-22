-- the names of songs that are by Post Malone

select
    a.name
from
    songs a,
    artists b
where
    a.id = b.id
    and b.name = 'Post Malone';
