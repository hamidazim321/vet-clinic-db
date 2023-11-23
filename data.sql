/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES
('Agumon', '2020-02-03', 10.23, TRUE, 0),
('Gabumon', '2018-11-15', 8.0, TRUE, 2),
('Pikachu', '2021-01-07', 15.04, FALSE, 1),
('Devimon', '2017-05-12', 11.0, TRUE, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES
('Charmander', '2020-02-08', -11.0, FALSE, 0),
('Plantmon', '2021-11-15', -5.7, TRUE, 2),
('Squirtle', '1993-04-02', -12.13, FALSE, 3),
('Angemon', '2005-06-12', -45.0, TRUE, 1),
('Boarmon', '2005-06-07', 20.4, TRUE, 7),
('Blossom', '1998-10-13', 17.0, TRUE, 3),
('Ditto', '2022-05-14', 22.0, TRUE, 4);

INSERT INTO owners (fullname, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon')

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

UPDATE animals
SET owner_id = 
    CASE 
        WHEN name = 'Agumon' THEN 1
        WHEN name IN ('Gabumon', 'Pikachu') THEN 2
        WHEN name IN ('Devimon', 'Plantmon') THEN 3
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
        WHEN name IN ('Angemon', 'Boarmon') THEN 5
    END;

INSERT INTO vets (name, age, date_of_graduation) VALUES 
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (species_id, vet_id)
VALUES 
(
    (SELECT id FROM species WHERE name = 'Pokemon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher')
),
(
    (SELECT id FROM species WHERE name = 'Pokemon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
),
(
    (SELECT id FROM species WHERE name = 'Digimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
),
(
    (SELECT id FROM species WHERE name = 'Digimon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness')
);

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES 
(
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-05-24'
),
(
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-07-22'
),
(
    (SELECT id FROM animals WHERE name = 'Gabumon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-02'
),
(
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-01-05'
),
(
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-03-08'
),
(
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-05-14'
),
(
    (SELECT id FROM animals WHERE name = 'Devimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2021-05-04'
),
(
    (SELECT id FROM animals WHERE name = 'Charmander'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-24'
),
(
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-12-21'
),
(
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-08-10'
),
(
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2021-04-07'
),
(
    (SELECT id FROM animals WHERE name = 'Squirtle'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2019-09-29'
),
(
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-10-03'
),
(
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-11-04'
),
(
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-01-24'
),
(
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-05-15'
),
(
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-02-27'
),
(
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-08-03'
),
(
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-05-24'
),
(
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2021-01-11'
);
