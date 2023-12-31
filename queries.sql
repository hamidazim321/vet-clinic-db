/*Queries that provide answers to the questions from all projects.*/
-- Query all animals whose name ends with 'mon'
SELECT * FROM animals WHERE name LIKE '%mon';

-- Query all animals name born between 2016 and 2019
SELECT name FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Pikachu', 'Agumon')

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5

-- Find all animals that are neutered
SELECT * FROM animals WHERE neutered

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE NOT name = 'Gabumon'

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with 
-- the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.
BEGIN;
UPDATE animals SET species = 'Unspecified';
-- Verify that change was made.
SELECT * FROM animals;
--  roll back the change and verify that the species columns went back to the state before 
-- the transaction.
ROLLBACK;
SELECT * FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a 
-- name ending in mon.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon'
-- Update the animals table by setting the species column to pokemon for all animals that don't 
-- have species already set.
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
-- Verify that changes were made.
SELECT * FROM animals;
-- Commit the transaction
COMMIT;
-- Verify that changes persist after commit.
SELECT * FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;
--  verify if all records in the animals table still exists
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT point1;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO point1;
-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT COUNT(*) AS count_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS no_escapes FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS avg_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT SUM(escape_attempts), neutered FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg),MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT animals.name, species.name AS species, owners.fullname AS owner_name 
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.fullname = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.*, species.name AS species_name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name, owners.fullname AS owner_name
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(animals.id) AS animal_count, species.name
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS digimon, owners.fullname
FROM animals JOIN owners
ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.fullname = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.*, owners.fullname AS owner_name
FROM animals JOIN owners
ON owners.id = animals.owner_id
WHERE animals.escape_attempts = 0 AND owners.fullname = 'Dean Winchester';

-- Who owns the most animals?
SELECT owners.fullname, COUNT(animals.id) AS count_animals
FROM owners
LEFT JOIN animals ON animals.owner_id = owners.id
GROUP BY owners.fullname;


-- Who was the last animal seen by William Tatcher?
SELECT a.name AS animal_name, vets.name AS vet_name, v.visit_date
FROM visits v JOIN animals a ON v.animal_id = a.id
JOIN vets ON vets.id = v.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(a.id) AS animal_count, vets.name AS vet_name
FROM visits v JOIN animals a ON v.animal_id = a.id
JOIN vets ON vets.id = v.vet_id
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties
SELECT v.name AS vet_name, s.name AS speciality
FROM specializations sp
RIGHT JOIN vets v ON sp.vet_id = v.id
LEFT JOIN species s ON sp.species_id = s.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal, v.name AS vet, vs.visit_date 
FROM animals a 
JOIN visits vs ON a.id = vs.animal_id
JOIN vets v ON vs.vet_id = v.id
WHERE v.name = 'Stephanie Mendez' AND vs.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(vs.visit_date) AS visit_count
FROM animals a 
LEFT JOIN visits vs ON a.id = vs.animal_id
GROUP BY a.name
ORDER BY visit_count DESC;

-- Who was Maisy Smith's first visit?
SELECT v.name AS vet_name, a.name AS animal_name, vs.visit_date
FROM animals a JOIN visits vs ON a.id = vs.animal_id
JOIN vets v ON v.id = vs.vet_id
WHERE v.name = 'Maisy Smith'
ORDER BY vs.visit_date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT 
	a.name AS animal_name,
	s.name AS species,
	o.fullname AS owner_name,
	vs.visit_date,
	v.name AS vet_name,
	v.age AS vet_age,
	v.date_of_graduation AS vet_graduation_date,
	a.date_of_birth, 
	a.escape_attempts, 
	a.weight_kg, 
	a.neutered
FROM 
animals a JOIN visits vs ON a.id = vs.animal_id
JOIN vets v ON v.id = vs.vet_id
JOIN species s ON s.id = a.species_id
JOIN owners o ON o.id = a.owner_id
ORDER BY vs.visit_date DESC
LIMIT 1
;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits_without_specialization
FROM visits vs
JOIN vets v ON v.id = vs.vet_id
JOIN animals a ON a.id = vs.animal_id
LEFT JOIN specializations sp ON v.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT v.name AS vet_name, s.name AS species_name, COUNT(v.name) AS visit_count
FROM vets v JOIN visits vs ON vs.vet_id = v.id
JOIN animals a ON a.id = vs.animal_id
JOIN species s ON s.id = a.species_id
WHERE v.name = 'Maisy Smith'
GROUP BY v.name, s.name
ORDER BY visit_count DESC
LIMIT 1
;