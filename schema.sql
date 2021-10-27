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
