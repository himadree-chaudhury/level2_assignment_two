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
('Ella Vaughn', 'Misty Fjord'),
('Finn Baxter', 'Emerald Forest'),
('Grace Jensen', 'Starlight Mesa'),
('Henry Soto', 'Blue Canyon'),
('Isla Perry', 'Golden Prairie'),
('Jack Ramsey', 'Twilight Highlands'),
('Kylie Weber', 'Sapphire Coast'),
('Liam Ortiz', 'Ironwood Hills'),
('Mia Caldwell', 'Amber Wetlands'),
('Noah Lynch', 'Frostbite Tundra'),
('Olivia Crane', 'Sunset Crags'),
('Peter Hogan', 'Whispering Dunes'),
('Quinn Farley', 'Coral Reef'),
('Rachel Boone', 'Shadow Grove'),
('Sam Kirby', 'Lunar Plateau'),
('Tara Gill', 'Verdant Hollow');

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
('Amur Leopard', 'Panthera pardus orientalis', '1858-01-01', 'Critically Endangered'),
('Giant Panda', 'Ailuropoda melanoleuca', '1869-01-01', 'Vulnerable'),
('Indian Rhinoceros', 'Rhinoceros unicornis', '1758-01-01', 'Vulnerable'),
('Sumatran Orangutan', 'Pongo abelii', '1827-01-01', 'Critically Endangered'),
('Javan Hawk-Eagle', 'Nisaetus bartelsi', '1908-01-01', 'Endangered'),
('Saola', 'Pseudoryx nghetinhensis', '1992-05-01', 'Critically Endangered'),
('Ganges River Dolphin', 'Platanista gangetica', '1801-01-01', 'Endangered'),
('Himalayan Tahr', 'Hemitragus jemlahicus', '1816-01-01', 'Near Threatened'),
('Markhor', 'Capra falconeri', '1839-01-01', 'Near Threatened'),
('Asian Lion', 'Panthera leo persica', '1826-01-01', 'Endangered'),
('Siberian Crane', 'Leucogeranus leucogeranus', '1773-01-01', 'Critically Endangered'),
('Malayan Tapir', 'Tapirus indicus', '1819-01-01', 'Endangered'),
('Proboscis Monkey', 'Nasalis larvatus', '1787-01-01', 'Endangered'),
('Tibetan Antelope', 'Pantholops hodgsonii', '1826-01-01', 'Near Threatened'),
('Yangtze Finless Porpoise', 'Neophocaena asiaeorientalis', '1918-01-01', 'Critically Endangered'),
('Philippine Eagle', 'Pithecophaga jefferyi', '1896-01-01', 'Critically Endangered');


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
(2, 2, '2024-06-02 14:15:00', 'Crystal Lake', 'Adult observed drinking'),
(3, 3, '2024-06-03 09:45:00', 'Silver Plains', 'Small group foraging'),
(4, 4, '2024-06-04 17:20:00', 'Cedar Ridge', NULL),
(5, 5, '2024-06-05 06:50:00', 'Misty Fjord', 'Camera trap image at dawn'),
(6, 6, '2024-06-06 11:10:00', 'Emerald Forest', 'Heard vocalizations'),
(7, 7, '2024-06-07 15:25:00', 'Starlight Mesa', 'Mother with two juveniles'),
(8, 8, '2024-06-08 19:00:00', 'Blue Canyon', 'Feeding on low vegetation'),
(9, 9, '2024-06-09 07:40:00', 'Golden Prairie', NULL),
(10, 10, '2024-06-10 16:55:00', 'Twilight Highlands', 'Lone individual spotted'),
(11, 11, '2024-06-11 10:20:00', 'Sapphire Coast', 'Resting on rocky outcrop'),
(12, 12, '2024-06-12 18:30:00', 'Ironwood Hills', 'Pair seen at dusk'),
(13, 13, '2024-06-13 08:15:00', 'Amber Wetlands', 'Nest with eggs observed'),
(14, 14, '2024-06-14 13:45:00', 'Frostbite Tundra', NULL),
(15, 15, '2024-06-15 09:00:00', 'Sunset Crags', 'Hunting near cliff edge'),
(16, 16, '2024-06-16 12:30:00', 'Whispering Dunes', 'Scat and footprints found'),
(17, 17, '2024-06-17 14:50:00', 'Coral Reef', 'Swimming in shallow waters'),
(18, 18, '2024-06-18 20:10:00', 'Shadow Grove', NULL),
(19, 19, '2024-06-19 07:25:00', 'Lunar Plateau', 'Group grazing in open area'),
(20, 20, '2024-06-20 11:00:00', 'Verdant Hollow', 'Fledgling attempting flight');


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
WHERE sightings.sighting_id IS NULL
GROUP BY species.common_name;

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
    AND EXTRACT (HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
    ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN(
    SELECT DISTINCT ranger_id FROM sightings
);

