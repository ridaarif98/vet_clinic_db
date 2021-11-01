/* Database schema to keep the structure of entire database. */
/* Create Database*/
CREATE DATABASE vet_clinic;

/* This command will create animals table*/

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(200),
    date_of_birth DATE,
    escape_attempts INT,
    neutuered BOOLEAN,
    weight_kg FLOAT,
    PRIMARY KEY(id)
);


-- Add a column species of type string to your animals table
ALTER TABLE animals ADD COLUMN species VARCHAR(150);

-- Create a table named owners with the following columns: id: integer, full_name: string, age: integer
CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,  
  full_name varchar(200),
  age INT,
  PRIMARY KEY(id)
);


-- Create a table named species with the following columns:id: integer, name: string
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCAHR(150),
    PRIMARY KEY(id)
);

-- Modify animals table
-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT,
ADD CONSTRAINT constraint_fk FOREIGN KEY (species_id) REFERENCES species (id); 

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owners_id INT,
ADD CONSTRAINT constraint_fk FOREIGN KEY (owners_id) REFERENCES owners (id);



-- Create a table named vets
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCAHR(150),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

-- Create a "join table" called specializations to handle relationship between the tables species and vets
CREATE TABLE specializations(
    vet_id INT,
    species_id INT,
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    FOREIGN KEY(species_id) REFERENCES species(id),
    PRIMARY KEY(vet_id, species_id)
);

-- Create a "join table" called visits to handle relationship between the tables animals and vets
CREATE TABLE visits(
    vet_id INT,
    animal_id INT,
    visit_date  DATE,
    id INT GENERATED ALWAYS AS IDENTITY,
    FOREIGN KEY(vet_id) REFERENCES vets(id),
    FOREIGN KEY(animal_id) REFERENCES animals(id),
    PRIMARY KEY(id)
);


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
