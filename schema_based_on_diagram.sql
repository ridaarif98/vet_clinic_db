CREATE DATABASE clinic;

CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(200),
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR,
    FOREIGN KEY(patient_id) REFERENCES patients(id),
    PRIMARY KEY(id)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    paid_at TIMESTAMP,
    medical_history_id INT,
    FOREIGN KEY(medical_history_id) REFERENCES patients(medical_histories),
    PRIMARY KEY(id)
);


-- CREATE TABLE animals (
--     id INT GENERATED ALWAYS AS IDENTITY,
--     name varchar(200),
--     date_of_birth DATE,
--     escape_attempts INT,
--     neutuered BOOLEAN,
--     weight_kg FLOAT,
--     PRIMARY KEY(id)
-- );


-- CREATE TABLE specializations(
--     vet_id INT,
--     species_id INT,
--     FOREIGN KEY(vet_id) REFERENCES vets(id),
--     FOREIGN KEY(species_id) REFERENCES species(id),
--     PRIMARY KEY(vet_id, species_id)
-- );