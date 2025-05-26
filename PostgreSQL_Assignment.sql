-- Active: 1747414394824@@127.0.0.1@5432@conservation_db@public
CREATE TABLE rangers (
    ranger_id SERIAL UNIQUE PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
)


INSERT INTO rangers (name, region) VALUES
('Alice Monroe', 'Pine Valley'),
('Ben Harper', 'Crystal Lake'),
('Clara Dixon', 'Silver Plains'),
('Daniel Ford', 'Cedar Ridge'),
('Ella Vaughn', 'Misty Pass');

CREATE TABLE species(
    species_id SERIAL UNIQUE PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
)

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Amur Leopard', 'Panthera pardus orientalis', '1858-01-01', 'Endangered');

CREATE TABLE sightings(
    sighting_id SERIAL UNIQUE PRIMARY KEY,
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id),
    species_id INT NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(255) NOT NULL,
    notes TEXT
)

INSERT INTO sightings (ranger_id, species_id, sighting_time, location, notes) VALUES
(1, 1, '2024-06-01 08:30:00', 'Pine Valley', 'Fresh tracks near riverbank'),
(1, 2, '2024-06-02 14:15:00', 'Pine Valley', 'Adult observed drinking'),
(1, 2, '2024-06-03 09:45:00', 'Pine Valley', 'Small group foraging'),
(2, 4, '2024-06-04 17:20:00', 'Crystal Lake', NULL),
(4, 1, '2024-06-05 06:50:00', 'Cedar Ridge', 'Camera trap image at dawn'),
(5, 2, '2024-06-06 17:10:00', 'Misty Pass', 'Heard vocalizations'),
(5, 1, '2024-06-07 15:25:00', 'Misty Pass', 'Mother with two juveniles');


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;


-- Problem 1
INSERT INTO rangers (name,region) VALUES
('Derek Fox','Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- Problem 4
SELECT name, count(sighting_id) as total_sightings FROM rangers
JOIN sightings ON rangers.ranger_id = sightings.ranger_id
GROUP BY rangers.name;

-- Problem 5
SELECT common_name FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.sighting_id IS NULL;

-- Problem 6
SELECT species.common_name, sighting_time , rangers.name FROM sightings
JOIN species ON sightings.species_id =species.species_id
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE EXTRACT (YEAR FROM discovery_date) < 1800;

-- Problem 8
SELECT sighting_id, 
CASE 
    WHEN EXTRACT (HOUR FROM sighting_time) < 12 THEN 'Morning' 
    WHEN EXTRACT (HOUR FROM sighting_time) >= 12 
    AND EXTRACT (HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN(
    SELECT DISTINCT ranger_id FROM sightings
);

