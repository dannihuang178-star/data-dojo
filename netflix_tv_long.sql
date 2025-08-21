SELECT
    release_year,
    COUNT(*) AS total_shows,
    SUM(CASE
            WHEN CAST(SUBSTR(duration, 1, INSTR(duration, ' ') - 1) AS INTEGER) > 2
            THEN 1
            ELSE 0
        END) AS shows_gt_2_seasons,
    ROUND(SUM(CASE
             WHEN CAST(SUBSTR(duration, 1, INSTR(duration, ' ') - 1) AS INTEGER) > 2
             THEN 1
             ELSE 0
         END) * 100.0 / COUNT(*),2) AS percentage_gt_2_seasons
FROM netflix
WHERE
    type = 'TV Show' AND release_year BETWEEN 2016 AND 2020
GROUP BY
    release_year
ORDER BY
    release_year;
