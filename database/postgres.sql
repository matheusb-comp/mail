-- Create the basic database tables used by Postfix

CREATE TABLE IF NOT EXISTS virtual_domains (
  id SERIAL PRIMARY KEY,
  domain VARCHAR UNIQUE NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS virtual_users (
  id SERIAL PRIMARY KEY,
  domain_id INTEGER NOT NULL,
  email VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,

  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS virtual_aliases (
  id SERIAL PRIMARY KEY,
  domain_id INTEGER NOT NULL,
  source VARCHAR NOT NULL,
  destination VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,

  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
);
