
CREATE TABLE automobiles (
    id SERIAL PRIMARY KEY,
    color VARCHAR(25),
    make VARCHAR(25),
    model VARCHAR(50),
    owner_name VARCHAR(100),
    purchase_date TIMESTAMP,
    vin VARCHAR(25),
    model_year INT
);
