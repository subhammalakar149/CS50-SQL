-- list the titles of all movies in which both Bradley Cooper and Jennifer Lawrence starred

SELECT title
FROM
    movies,
    stars,
    people
WHERE
    movies.id = stars.movie_id
    AND people.id = stars.person_id
    AND name IN ('Bradley Cooper', 'Jennifer Lawrence')
GROUP BY
    title
HAVING COUNT(*)>1;
