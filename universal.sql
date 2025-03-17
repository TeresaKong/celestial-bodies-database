-- 创建 galaxy 表
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    age_in_millions_of_years NUMERIC(10,1) NOT NULL,
    diameter_in_light_years NUMERIC(10,1) NOT NULL,
    distance_from_earth_in_light_years NUMERIC(10,1)
);

-- 插入 galaxy 表数据
INSERT INTO galaxy (name, description, age_in_millions_of_years, diameter_in_light_years, distance_from_earth_in_light_years)
VALUES
  ('Milky Way', 'Our home galaxy', 13600, 100000, 0),
  ('Andromeda', 'Nearest spiral galaxy', 10000, 220000, 2537),
  ('Triangulum', 'Small spiral galaxy', 5000, 60000, 3000),
  ('Sombrero', 'Spiral galaxy', 8000, 50000, 29000),
  ('Whirlpool', 'Grand design galaxy', 7000, 60000, 23000),
  ('Pinwheel', 'Face-on spiral galaxy', 6000, 70000, 21000);

-- 创建 star 表
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    age_in_millions_of_years NUMERIC(10,1) NOT NULL,
    diameter_in_km NUMERIC(10,1) NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL
);

-- 插入 star 表数据
INSERT INTO star (name, description, age_in_millions_of_years, diameter_in_km, galaxy_id)
VALUES
  ('Sun', 'Our home star', 4600, 1392700, 1),
  ('Alpha Centauri', 'Closest star system', 6000, 1670000, 1),
  ('Sirius', 'Brightest star', 250, 2400000, 1),
  ('Betelgeuse', 'Red supergiant', 800, 1300000000, 2),
  ('Vega', 'Bright star in Lyra', 455, 2360000, 3),
  ('Polaris', 'North Star', 700, 5200000, 4);

-- 创建 planet 表
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    age_in_millions_of_years NUMERIC(10,1) NOT NULL,
    diameter_in_km NUMERIC(10,1) NOT NULL,
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    star_id INT REFERENCES star(star_id) NOT NULL
);

-- 插入 planet 表数据
INSERT INTO planet (name, description, age_in_millions_of_years, diameter_in_km, has_life, is_spherical, star_id)
VALUES
  ('Earth', 'Our home planet', 4500, 12742, true, true, 1),
  ('Mars', 'The Red Planet', 4500, 6779, false, true, 1),
  ('Jupiter', 'Largest planet', 4600, 139820, false, true, 1),
  ('Saturn', 'Ringed planet', 4500, 116460, false, true, 1),
  ('Proxima b', 'Exoplanet', 4800, 14000, false, true, 2),
  ('Kepler-22b', 'Habitable exoplanet', 6000, 30000, true, true, 3),
  ('HD 209458b', 'Hot Jupiter', 5000, 140000, false, true, 4),
  ('TRAPPIST-1e', 'Potentially habitable', 7500, 9000, true, true, 5),
  ('WASP-12b', 'Puffy planet', 2000, 240000, false, true, 6),
  ('55 Cancri e', 'Super-Earth', 8000, 25000, false, true, 1),
  ('Gliese 581c', 'Potentially habitable', 7000, 18000, true, true, 2),
  ('Kepler-186f', 'Earth-like exoplanet', 4000, 14000, true, true, 3);

-- 创建 moon 表
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    age_in_millions_of_years NUMERIC(10,1) NOT NULL,
    diameter_in_km NUMERIC(10,1) NOT NULL,
    planet_id INT REFERENCES planet(planet_id) NOT NULL
);

-- 插入 moon 表数据
INSERT INTO moon (name, description, age_in_millions_of_years, diameter_in_km, planet_id)
VALUES
  ('Moon', 'Earth''s natural satellite', 4500, 3474, 1),
  ('Phobos', 'Mars'' moon', 4500, 22, 2),
  ('Deimos', 'Mars'' moon', 4500, 12, 2),
  ('Europa', 'Jupiter''s moon', 4600, 3122, 3),
  ('Ganymede', 'Jupiter''s moon', 4600, 5268, 3),
  ('Titan', 'Saturn''s moon', 4500, 5150, 4),
  ('Enceladus', 'Saturn''s moon', 4500, 504, 4),
  ('Triton', 'Neptune''s moon', 4500, 2707, 5),
  ('Io', 'Jupiter''s moon', 4600, 3643, 3),
  ('Callisto', 'Jupiter''s moon', 4600, 4821, 3),
  ('Rhea', 'Saturn''s moon', 4500, 1528, 4),
  ('Iapetus', 'Saturn''s moon', 4500, 1470, 4),
  ('Oberon', 'Uranus'' moon', 4500, 1523, 6),
  ('Titania', 'Uranus'' moon', 4500, 1578, 6),
  ('Miranda', 'Uranus'' moon', 4500, 472, 6),
  ('Ariel', 'Uranus'' moon', 4500, 1158, 6),
  ('Umbriel', 'Uranus'' moon', 4500, 1169, 6),
  ('Charon', 'Pluto''s moon', 4500, 1212, 7),
  ('Nix', 'Pluto''s moon', 4500, 42, 7),
  ('Hydra', 'Pluto''s moon', 4500, 55, 7);

-- 创建 planet_moon 表（多对多关系）
CREATE TABLE planet_moon (
    planet_id INT REFERENCES planet(planet_id) NOT NULL,
    moon_id INT REFERENCES moon(moon_id) NOT NULL,
    PRIMARY KEY (planet_id, moon_id)
);

-- 插入 planet_moon 表数据
INSERT INTO planet_moon (planet_id, moon_id)
VALUES
  (1, 1),  -- Earth 的卫星是 Moon
  (2, 2),  -- Mars 的卫星是 Phobos
  (2, 3),  -- Mars 的卫星是 Deimos
  (3, 4),  -- Jupiter 的卫星是 Europa
  (3, 5),  -- Jupiter 的卫星是 Ganymede
  (3, 9),  -- Jupiter 的卫星是 Io
  (3, 10), -- Jupiter 的卫星是 Callisto
  (4, 6),  -- Saturn 的卫星是 Titan
  (4, 7),  -- Saturn 的卫星是 Enceladus
  (4, 11), -- Saturn 的卫星是 Rhea
  (4, 12), -- Saturn 的卫星是 Iapetus
  (5, 8),  -- Neptune 的卫星是 Triton
  (6, 13), -- Uranus 的卫星是 Oberon
  (6, 14), -- Uranus 的卫星是 Titania
  (6, 15), -- Uranus 的卫星是 Miranda
  (6, 16), -- Uranus 的卫星是 Ariel
  (6, 17), -- Uranus 的卫星是 Umbriel
  (7, 18), -- Pluto 的卫星是 Charon
  (7, 19), -- Pluto 的卫星是 Nix
  (7, 20); -- Pluto 的卫星是 Hydra