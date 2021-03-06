/* Populate database with sample data. */
/* These quries will insert data into animal table */
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', 'Feb 3, 2020', 10.23, TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', 'Nov 15, 2018', 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', 'Jan 7, 2021', 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', 'May 12, 2017', 11, TRUE, 5);

--  His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', 'Feb 8, 2020', 11, FALSE, 0);

--  Her name is Plantmon. She was born on Nov 15th, 2022, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', 'Nov 15, 2022', 5.7, TRUE, 2);

--  His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to 3 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', 'Apr 2, 1993', 12.13, FALSE, 3);

-- His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', 'Jun 12, 2005', -45, TRUE, 1);

-- His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', 'Jun 7, 2005', 20.4, TRUE, 7);

-- Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', 'Oct 13, 1998', 17, TRUE, 3);


-- Insert the data into the owners table
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), 
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);


-- Insert the data into the species table
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Modify your inserted animals so it includes the species_id
BEGIN;
UPDATE animals SET species_id=1 WHERE name LIKE '%mon';
UPDATE animals SET species_id=2 WHERE name NOT LIKE '%mon';
COMMIT;


-- Modify your inserted animals to include owner information (owner_id)
BEGIN;
UPDATE animals SET owners_id=1 WHERE name LIKE 'Agumon';
UPDATE animals SET owners_id=2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owners_id=3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id=4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id=5 WHERE name IN ('Angemon', 'Boarmon');
COMMIT;

-- Insert the data for vets
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet William Tatcher', 45, 'Apr 23, 2000'),
('Vet Maisy Smith', 26, 'Jan 17, 2019'),
('Vet Stephanie Mendez', 64, 'May 4, 1981'),
('Vet Jack Harkness', 38, 'Jun 8, 2008');

-- Insert the data for specialties
INSERT INTO specialization (vet_id, species_id) VALUES (1,1),
(3,1),
(3,2),
(4,2);

-- Insert data for visits
INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES (1, 1, 'May 24, 2020'),
(1, 3, 'Jul 22, 2020'),
(5, 4, 'Feb 2, 2021'),
(8, 2, 'Jan 5, 2020'),
(8, 2, 'Mar 8, 2020'),
(8, 2, 'May 14, 2020'),
(2, 4, 'Feb 24,2021'),
(4, 3, 'Sep 29,2019'),
(9, 4, 'Nov 4,2020'),
(6, 2, 'Jan 24,2019'),
(6, 2, 'May 15,2019'),
(6, 2, 'Feb 27,2020'),
 (6, 2, 'Aug 3,2020'),
(7, 3, 'May 24,2020'),
(7, 1, 'Jan 11,2021');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';