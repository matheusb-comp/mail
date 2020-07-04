-- Create test data

INSERT INTO relay_passwords
  (id, relay, username, plain_password, created_at, updated_at)
VALUES
  (1, '[mail.isp.example.com]:587', 'user-com', 'password', NOW(), NOW()),
  (2, '[mail.example.net]:submission', 'user-net', 'password', NOW(), NOW()),
;

INSERT INTO virtual_domains
  (id, active, domain, created_at, updated_at)
VALUES
  (1, TRUE, 'example.com', NOW(), NOW()),
  (2, TRUE, 'hostname', NOW(), NOW()),
  (3, TRUE, 'local.host', NOW(), NOW())
;

INSERT INTO virtual_users
  (domain_id, email, password, created_at, updated_at)
VALUES
  -- The passwords are BCRYPT hashes for 'password'
  (1, 'name1', '$2y$10$e7NSmtRjTkoDR2AJV7DDM.DAfsV/if5WQxm1iWc1TLrRFQ7WwUVfK', NOW(), NOW()),
  (1, 'name2', '$2y$10$ZKSc2HALy2EspfGdrFNuIu8CdHZSQ/uUBXkmzO5fxJV2bDg7e8fbi', NOW(), NOW()),
  (1, 'name3', '$2y$10$pFJWsEugh5x5dNgSxHMPOu/iJviLmHjYyLI2eEksMgv2DBxIb9Pmq', NOW(), NOW()),
  (2, 'name1', '$2y$10$PjqN3WwvmkjUivSZZOwfO.3tm00c1m3mXTv26Peq2rquu4KGdFmoK', NOW(), NOW()),
  (2, 'name2', '$2y$10$7fVE1ijZ74nMgNyH6qo0cu08qlEckbZKQ3g715ewMP/UAyxHTb/Um', NOW(), NOW()),
  (2, 'name3', '$2y$10$ZHrJWD6WGnmha8SgaVh/NOiTYsZ93SbVNgtVSdUnrIqwBgmgYePqS', NOW(), NOW()),
  (3, 'name', '$2y$10$Gg1NyM.dvnTHLVHzR1rW/.az5evsGVOEiYPmB5FAg7TuXrKRzdWkG', NOW(), NOW())
;

INSERT INTO virtual_aliases
  (domain_id, source, destination, created_at, updated_at)
VALUES
  (1, 'alias', 'name1@example.com', NOW(), NOW()),
  (1, 'alias', 'other@place.external', NOW(), NOW()),
  (2, 'alias', 'name3@other.place', NOW(), NOW()),
  (3, 'alias', 'name2@hostname', NOW(), NOW())
;
