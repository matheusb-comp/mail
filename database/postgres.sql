-- Create the basic database tables used by Postfix

CREATE TABLE IF NOT EXISTS relay_passwords (
  id BIGSERIAL PRIMARY KEY,
  relay VARCHAR NOT NULL,
  username VARCHAR NOT NULL,
  plain_password VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS virtual_domains (
  id BIGSERIAL PRIMARY KEY,
  active BOOLEAN NOT NULL,
  domain VARCHAR UNIQUE NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS virtual_users (
  id BIGSERIAL PRIMARY KEY,
  domain_id BIGINT NOT NULL,
  email VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,

  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS virtual_aliases (
  id BIGSERIAL PRIMARY KEY,
  domain_id BIGINT NOT NULL,
  source VARCHAR NOT NULL,
  destination VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,

  FOREIGN KEY (domain_id) REFERENCES virtual_domains(id) ON DELETE CASCADE
);
