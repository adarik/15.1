CREATE TABLE "animal_type"
(
    "id"   text primary key,
    "type" text
);

CREATE TABLE "breeds"
(
    "id"    text primary key,
    "breed" text
);

CREATE TABLE "colors"
(
    id      text primary key,
    "color" text
);

CREATE TABLE "animals_normal"
(
    "id"            integer primary key autoincrement,
    "age"           text,
    "animal_id"     text,
    "type"          text,
    "name"          text,
    "breed"         text,
    "color_1"       text,
    "color_2"       text,
    "date_of_birth" text,
    FOREIGN KEY (type) references animal_type ("id"),
    FOREIGN KEY (breed) references breeds ("id"),
    FOREIGN KEY (color_1) references colors ("id"),
    FOREIGN KEY (color_2) references colors ("id")
);

CREATE TABLE "outcome"
(
    "id"           integer primary key autoincrement,
    "animal_id"    text,
    "program"      text,
    "status"       text,
    "coming_month" integer,
    "coming_year"  integer,
    FOREIGN KEY ("animal_id") references animals_normal ("animal_id")
);


INSERT INTO animals_normal (age, animal_id, type, name, breed, color_1, color_2, date_of_birth)
SELECT age_upon_outcome,
       animal_id,
       animal_type,
       name,
       breed,
       color1,
       color2,
       date_of_birth
FROM animals;

-- INSERT INTO animal_type (type)
-- VALUES ('Cat');

INSERT INTO breeds (id, breed)
SELECT DISTINCT breed, breed
from animals
ORDER BY animals.breed;


INSERT INTO animal_type (id, type)
SELECT DISTINCT animal_type, animal_type
from animals
ORDER BY animals.animal_type;


INSERT INTO colors(id, color)
SELECT DISTINCT color1, color1
from animals
ORDER BY animals.color1;

INSERT INTO outcome(animal_id, program, status, coming_month, coming_year)
SELECT animal_id, outcome_subtype, outcome_type, outcome_month, outcome_year
from animals
ORDER BY animal_id;

SELECT animals_normal.id,
       age,
       animals_normal.animal_id,
       type,
       name,
       breed,
       color_1,
       color_2,
       date_of_birth,
       outcome.program,
       outcome.status,
       outcome.coming_month,
       outcome.coming_year
FROM animals_normal
         INNER JOIN outcome ON animals_normal.animal_id = outcome.animal_id
WHERE animals_normal.id = 1;