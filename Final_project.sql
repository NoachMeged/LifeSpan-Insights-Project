USE final_project;
-- see all the table

SELECT * FROM life_expectancy;
SELECT * FROM calories_per_day;
select * from alcohol_consumption;
select * from obesity;
select * from gdp_per_year;
select * from hdi;
select * from physical_inactivity;
select * from salt_intake_clean;
select * from smoking_data;


-- Massive join
WITH Ranked AS (
    SELECT 
        le.year, 
        le.country, 
        le.iso3, 
        le.life_expectancy, 
        le.life_expectancy_male, 
        le.life_expectancy_female, 
        le.life_expectancy_60, 
        le.life_expectancy_60_male, 
        le.life_expectancy_60_female, 
        le.life_expectancy_primary_key,
        c.kcal_per_day,
        a.alcohol_in_units_per_capita,
        o.obesity_procent,
        o.obesity_procent_female,
        o.obesity_procent_male,
        pi.inactivity_procent,
        pi.inactivity_procent_female,
        pi.inactivity_procent_male,
        sic.salt_intake_pd_median,
        sic.salt_intake_pd_median_female,
        sic.salt_intake_pd_median_male,
        vfc.vegetables_kilograms_per_year,
        vfc.fruits_kilograms_per_year,
        sd.smoking_procent, -- Only including smoking data
        ROW_NUMBER() OVER (
            PARTITION BY le.iso3, le.year 
            ORDER BY g.gdp_usd_p_year DESC, c.kcal_per_day DESC
        ) AS row_num
    FROM life_expectancy AS le
    LEFT JOIN calories_per_day AS c
        ON le.iso3 = c.iso3 AND le.year = c.year
    LEFT JOIN alcohol_consumption AS a
        ON le.iso3 = a.iso3 AND le.year = a.year
    LEFT JOIN obesity AS o
        ON le.iso3 = o.iso3 AND le.year = o.year
    LEFT JOIN physical_inactivity AS pi
        ON le.iso3 = pi.iso3 AND le.year = pi.year
    LEFT JOIN salt_intake_clean AS sic
        ON le.iso3 = sic.iso3 AND le.year = sic.year
    LEFT JOIN vegetable_fruit_consumption AS vfc
        ON le.iso3 = vfc.iso3 AND le.year = vfc.year
    LEFT JOIN gdp_per_year AS g
        ON le.iso3 = g.iso3 AND le.year = g.year
    LEFT JOIN smoking_data AS sd
        ON le.iso3 = sd.iso3 AND le.year = sd.year
)
SELECT * 
FROM Ranked 
WHERE row_num = 1
ORDER BY iso3 ASC, year ASC;







-- build primary key

ALTER TABLE life_expectancy
ADD COLUMN life_expectancy_primary_key VARCHAR(50);

ALTER TABLE calories_per_day
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE alcohol_consumption
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE obesity
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE gdp_per_year
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE hdi
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE physical_inactivity
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE salt_intake_clean
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

ALTER TABLE smoking_data
ADD COLUMN life_expectancy_primary_key VARCHAR(255);

-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Run the UPDATE query
UPDATE life_expectancy
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE calories_per_day
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE alcohol_consumption
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE obesity
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE gdp_per_year
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE hdi
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE physical_inactivity
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE salt_intake_clean
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE smoking_data
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

SELECT * FROM life_expectancy;

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

-- Step 1: Set Primary Key in life_expectancy
ALTER TABLE life_expectancy 
ADD PRIMARY KEY (life_expectancy_primary_key);
ALTER TABLE life_expectancy 
ADD PRIMARY KEY (life_expectancy_primary_key);

-- Step 2: Add Foreign Keys in all other tables
ALTER TABLE calories_per_day 
ADD CONSTRAINT fk_calories_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE alcohol_consumption 
ADD CONSTRAINT fk_alcohol_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE obesity 
ADD CONSTRAINT fk_obesity_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE gdp_per_year 
ADD CONSTRAINT fk_gdp_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE hdi 
ADD CONSTRAINT fk_hdi_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE physical_inactivity 
ADD CONSTRAINT fk_physical_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE salt_intake_clean 
ADD CONSTRAINT fk_salt_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;

ALTER TABLE smoking_data 
ADD CONSTRAINT fk_smoking_life_expectancy 
FOREIGN KEY (life_expectancy_primary_key) 
REFERENCES life_expectancy(life_expectancy_primary_key) 
ON DELETE CASCADE;


ALTER TABLE salt_intake_clean 
ADD COLUMN life_expectancy_primary_key VARCHAR(50);

ALTER TABLE obesity 
ADD COLUMN life_expectancy_primary_key VARCHAR(50);

ALTER TABLE physical_inactivity 
ADD COLUMN life_expectancy_primary_key VARCHAR(50);

UPDATE salt_intake_clean 
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE obesity 
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

UPDATE physical_inactivity 
SET life_expectancy_primary_key = CONCAT(iso3, '_', year);

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;




