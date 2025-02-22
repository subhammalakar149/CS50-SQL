-- names of any songs that have danceability, energy, and valence greater than 0.75

select
    name
from
    songs
where
    danceability > 0.75
    and energy > 0.75
    and valence > 0.75;
