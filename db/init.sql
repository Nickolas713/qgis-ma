-- db/init.sql

CREATE EXTENSION IF NOT EXISTS postgis;

-- 1) limite da cidade (polígono simplificado, serve só pra demo WMS)
DROP TABLE IF EXISTS limite_fusagasuga;
CREATE TABLE limite_fusagasuga (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    geom geometry(Polygon, 4326) NOT NULL
);

-- polígono simples ao redor da área urbana de Fusagasugá
INSERT INTO limite_fusagasuga (nome, geom)
VALUES (
    'Fusagasugá - área urbana (aprox.)',
    ST_GeomFromText(
        'POLYGON((
            -74.3820 4.3260,
            -74.3450 4.3260,
            -74.3370 4.3480,
            -74.3370 4.3660,
            -74.3450 4.3790,
            -74.3700 4.3830,
            -74.3820 4.3720,
            -74.3820 4.3260
        ))',
        4326
    )
);

-- 2) pontos de interesse
DROP TABLE IF EXISTS pontos_interes_fusa;
CREATE TABLE pontos_interes_fusa (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    categoria TEXT,
    geom geometry(Point, 4326) NOT NULL
);

-- Plaza / Parque Principal
INSERT INTO pontos_interes_fusa (nome, categoria, geom)
VALUES (
    'Parque Principal de Fusagasugá',
    'praça',
    ST_SetSRID(ST_MakePoint(-74.3638, 4.3369), 4326)
);

-- Hospital San Rafael
INSERT INTO pontos_interes_fusa (nome, categoria, geom)
VALUES (
    'Hospital San Rafael',
    'saúde',
    ST_SetSRID(ST_MakePoint(-74.3685, 4.3309), 4326)
);

-- Terminal de Transportes
INSERT INTO pontos_interes_fusa (nome, categoria, geom)
VALUES (
    'Terminal de Transportes',
    'transporte',
    ST_SetSRID(ST_MakePoint(-74.3645, 4.3455), 4326)
);

-- 3) vias principais (linha simples só pra teste)
DROP TABLE IF EXISTS vias_principais_fusa;
CREATE TABLE vias_principais_fusa (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    geom geometry(LineString, 4326) NOT NULL
);

-- linha norte-sul passando perto do centro
INSERT INTO vias_principais_fusa (nome, geom)
VALUES (
    'Eje Central - Demo',
    ST_GeomFromText(
        'LINESTRING(-74.3650 4.3250, -74.3645 4.3300, -74.3640 4.3360, -74.3635 4.3440, -74.3630 4.3500)',
        4326
    )
);
