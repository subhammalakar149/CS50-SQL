-- returns the average energy of songs that are by Drake

select
    avg(a.energy) as avg_energy
from
    songs a,
    artists b
where
    a.id = b.id
    and b.name = 'Drake';
