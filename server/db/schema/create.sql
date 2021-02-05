-- Drop and recreate Users table (Example)

DROP TABLE IF EXISTS users
CASCADE;

CREATE TABLE users
(
  id SERIAL PRIMARY KEY NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  avatar VARCHAR(255),
  created_at TIMESTAMP DEFAULT current_timestamp
);

-- Drop and recreate Widgets table (Example)

DROP TABLE IF EXISTS lots
CASCADE;
CREATE TABLE lots
(
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  title VARCHAR(255) NOT NULL,
  size INTEGER NOT NULL,
  cost_per_month NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
  is_irrigated BOOLEAN NOT NULL DEFAULT FALSE,
  suggested_term INTEGER NOT NULL DEFAULT 12,
  condition_rating INTEGER,
  available_date DATE NOT NULL DEFAULT current_timestamp,
  lot_type VARCHAR(255) NOT NULL,
  lot_description TEXT NOT NULL,
  is_leased BOOLEAN DEFAULT FALSE,
  street_address VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL,
  lat DECIMAL(8,6),
  long DECIMAL(9,6),
  created_at TIMESTAMP DEFAULT current_timestamp,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

DROP TABLE IF EXISTS images
CASCADE;

CREATE TABLE images
(
  id SERIAL PRIMARY KEY NOT NULL,
  lot_id INTEGER REFERENCES lots(id) ON DELETE CASCADE NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT current_timestamp
);

DROP TABLE IF EXISTS leases
CASCADE;
CREATE TABLE leases
(
  id SERIAL PRIMARY KEY NOT NULL,
  lot_id INTEGER REFERENCES lots(id) ON DELETE CASCADE NOT NULL,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  renter_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  created_at TIMESTAMP DEFAULT current_timestamp,
  term_length INTEGER NOT NULL,
  total_cost NUMERIC(12, 2) NOT NULL DEFAULT 0.00
);

DROP TABLE IF EXISTS messages
CASCADE;

CREATE TABLE messages
(
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  renter_id INTEGER REFERENCES users(id) ON DELETE CASCADE NOT NULL,
  lot_id INTEGER REFERENCES lots(id) ON DELETE CASCADE NOT NULL,
  text_body TEXT NOT NULL,
  written_by INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT current_timestamp
);