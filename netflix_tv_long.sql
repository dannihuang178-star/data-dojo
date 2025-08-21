-- 1. Create a base table `base_data` to filter and clean the raw data.
-- This CTE isolates TV shows from 2016 to 2020 and prepares the duration column for analysis.
WITH base_data AS (
    SELECT
        release_year,
        CAST(SUBSTR(duration, 1, INSTR(duration, ' ') - 1) AS INTEGER) AS numeric_duration
    FROM
        netflix
    WHERE
        type = 'TV Show' AND release_year BETWEEN 2016 AND 2020
),

-- 2. Create an aggregated table `yearly_counts` to calculate the total and long-running shows.
-- This CTE groups the base data by year to get the key metrics for percentage calculation.
yearly_counts AS (
    SELECT
        release_year,
        COUNT(*) AS total_shows,
        SUM(CASE
                WHEN numeric_duration > 2
                THEN 1
                ELSE 0
            END) AS shows_gt_2_seasons
    FROM
        base_data
    GROUP BY
        release_year
)

-- 3. Select the final results and calculate the percentage.
-- The final query joins the aggregated data and performs the necessary calculation for the final output.
SELECT
    release_year,
    total_shows,
    shows_gt_2_seasons,
    ROUND(CAST(shows_gt_2_seasons AS REAL) * 100 / total_shows, 2) AS percentage_gt_2_seasons
FROM
    yearly_counts
ORDER BY
    release_year;
