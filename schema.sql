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
