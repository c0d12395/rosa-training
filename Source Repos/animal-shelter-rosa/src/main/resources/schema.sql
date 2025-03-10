
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    birthdate TIMESTAMP(6) WITHOUT TIME ZONE,
    description VARCHAR(255),
    name VARCHAR(255),
    type VARCHAR(255) CHECK (type IN ('DOG', 'CAT', 'BIRD', 'RABBIT', 'HORSE', 'PIG', 'SNAKE', 'OTHER'))
);
