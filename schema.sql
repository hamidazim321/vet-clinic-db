/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg NUMERIC
);

ALTER TABLE animals ADD
species VARCHAR(255);

CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY,
	fullname VARCHAR(255),
	age INT,
	PRIMARY KEY (id)
);

CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(255),
	PRIMARY KEY (id)
);

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT,
ADD PRIMARY KEY (id),
ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species (id)
    ON DELETE CASCADE,
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owners
	FOREIGN KEY (owner_id)
	REFERENCES owners (id)
	ON DELETE CASCADE;

