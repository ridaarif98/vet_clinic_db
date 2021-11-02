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


CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY(invoice_id) REFERENCES  invoices(id),
    FOREIGN KEY(treatment_id) REFERENCES  treatments(id),
    PRIMARY KEY(id)
);

CREATE TABLE treatments(
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(70),
    name VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE TABLE treatment_histories (
    id INT GENERATED ALWAYS AS IDENTITY,
    medical_history_id INT,
    treatment_id INT,
    FOREIGN KEY( medical_history_id) REFERENCES  medical_histories(id),
    FOREIGN KEY(treatment_id) REFERENCES  treatments(id),
    PRIMARY KEY(id)
);