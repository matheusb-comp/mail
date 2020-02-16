-- Create test data

INSERT INTO virtual_domains
  (id, domain, created_at, updated_at)
VALUES
  (1, 'example.com', NOW(), NOW()),
  (2, 'hostname', NOW(), NOW()),
  (3, 'local.host', NOW(), NOW());

-- The password is a BCRYPT hash for 'secret'
INSERT INTO virtual_users
  (domain_id, email, password, created_at, updated_at)
VALUES
  (1, 'name1', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (1, 'name2', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (1, 'name3', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (2, 'name1', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (2, 'name2', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (2, 'name3', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW()),
  (3, 'name', '$2y$12$30swB3HBoVxDkFwQXZlXwe/Pca3dHsA/yKhh3jP5qKi/pF5AwmcYK', NOW(), NOW());

INSERT INTO virtual_aliases
  (domain_id, source, destination, created_at, updated_at)
VALUES
  (1, 'alias', 'name1@example.com', NOW(), NOW()),
  (2, 'alias', 'name3@other.place', NOW(), NOW()),
  (3, 'alias', 'name2@hostname', NOW(), NOW());
