/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE netuered=TRUE AND escape_attempts<3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
-- or you can use this command
SELECT date_of_birth FROM animals WHERE name IN('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE netuered=TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name!='Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg 
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made.
-- Then roll back the change and verify that species columns went back to the state before tranasction.

BEGIN;
UPDATE animals SET species='unspecified';
-- Optional to verify species column is updated or not
SELECT * FROM animals;
ROLLBACK;



BEGIN;
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species='pokemon' WHERE species IS NULL;

-- Commit the transaction.
COMMIT;

-- Verify that change was made and persists after commit.
SELECT * FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;



BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > 'Jan 1,2022';

-- Create a savepoint for the transaction.
SAVEPOINT SP1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * (-1);

-- Rollback to the savepoint
ROLLBACK TO SP1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;

-- Commit transaction
COMMIT;


-- How many animals are there?
SELECT COUNT(name) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(name) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- OR
SELECT SUM(weight_kg)/COUNT(weight_kg) AS avg_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT neutered, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY neutered;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT neutered, AVG(escape_attempts) FROM animals WHERE date_part('year', date_of_birth) BETWEEN 1990 AND 2000 GROUP BY neutered;


-- Queries using JOIN.
-- What animals belong to Melody Pond?
SELECT A.id, name, date_of_birth, weight_kg, A.owner_id, O.id FROM animals A INNER JOIN owners O ON A.owner_id = O.id WHERE O.id = 4;

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.id, A.name,S.name AS species_name, date_of_birth, weight_kg, owner_id, species_id, S.id FROM animals A
LEFT JOIN species S ON species_id = S.id WHERE S.NAME LIKE 'Pokemon'; 

-- OR you can use this query
SELECT A.id, A.name,S.name AS species_name, date_of_birth, weight_kg, owner_id, species_id, S.id FROM animals A
LEFT JOIN species S ON species_id = S.id WHERE S.id=1;

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT A.name, O.full_name AS owner_name FROM owners O LEFT JOIN animals A ON owner_id=O.id;  

-- How many animals are there per species?
SELECT COUNT(A.name), S.id FROM animals A LEFT JOIN species S ON species_id=S.id GROUP BY S.id; 

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name, S.name as species_name, O.full_name FROM animals A 
  JOIN species S ON species_id = S.id
  JOIN owners O ON owner_id=O.id
 WHERE species_id =2 AND O.full_name LIKE 'Jennifer Orwell'; 
 
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name AS animal_name, O.full_name AS owner_name, escape_attempts FROM animals A INNER JOIN owners O ON owner_id= O.id WHERE O.full_name LIKE 'Jennifer Orwell' AND escape_attempts =0; 

-- Who owns the most animals?
SELECT COUNT(owner_id),O.full_name FROM animals A FULL OUTER JOIN owners O ON owner_id= O.id GROUP BY O.id; 

