-- Create test data

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
  -- The password is a BCRYPT hash for 'secret'
  (1, 'name1', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (1, 'name2', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (1, 'name3', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (2, 'name1', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (2, 'name2', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (2, 'name3', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (3, 'name', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW())
;

INSERT INTO virtual_aliases
  (domain_id, source, destination, created_at, updated_at)
VALUES
  (1, 'alias', 'name1@example.com', NOW(), NOW()),
  (1, 'alias', 'other@place.external', NOW(), NOW()),
  (2, 'alias', 'name3@other.place', NOW(), NOW()),
  (3, 'alias', 'name2@hostname', NOW(), NOW())
;
