CREATE EXTENSION IF NOT EXISTS postgis;

-- manzanas
DROP TABLE IF EXISTS fusa_manzanas;
CREATE TABLE fusa_manzanas (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20),
    nome VARCHAR(120),
    geom geometry(Polygon, 4326) NOT NULL
);

INSERT INTO fusa_manzanas (codigo, nome, geom)
VALUES (
    'MZ-001',
    'Centro',
    ST_GeomFromText(
        'POLYGON((
            -74.3665 4.3385,
            -74.3625 4.3385,
            -74.3625 4.3345,
            -74.3665 4.3345,
            -74.3665 4.3385
        ))', 4326
    )
);

-- prédios
DROP TABLE IF EXISTS fusa_predios;
CREATE TABLE fusa_predios (
    id SERIAL PRIMARY KEY,
    cod_catastral VARCHAR(50),
    endereco TEXT,
    bairro TEXT,
    manzana_id INT REFERENCES fusa_manzanas(id) ON DELETE SET NULL,
    frente_metros NUMERIC(10,2),
    area_terreno NUMERIC(12,2),
    url_fachada TEXT,
    url_pano_360 TEXT,
    geom geometry(Polygon, 4326) NOT NULL
);

INSERT INTO fusa_predios (
    cod_catastral, endereco, bairro, manzana_id,
    frente_metros, area_terreno,
    url_fachada, url_pano_360, geom
)
VALUES (
    'FUSA-0001-0001',
    'Carrera 6 # 5-20',
    'Centro',
    1,
    8.50,
    120.00,
    'http://fusa-assets:80/assets/fotos/fachada_0001.jpg',
    'http://fusa-assets:80/assets/fotos360/pano_0001.jpg',
    ST_GeomFromText(
        'POLYGON((
            -74.3655 4.3375,
            -74.3650 4.3375,
            -74.3650 4.3370,
            -74.3655 4.3370,
            -74.3655 4.3375
        ))', 4326
    )
);

-- vias
DROP TABLE IF EXISTS fusa_vias;
CREATE TABLE fusa_vias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(120),
    tipo VARCHAR(50),
    geom geometry(LineString, 4326) NOT NULL
);

INSERT INTO fusa_vias (nome, tipo, geom)
VALUES (
    'Carrera 6',
    'Principal',
    ST_GeomFromText(
        'LINESTRING(-74.3660 4.3400, -74.3658 4.3380, -74.3655 4.3360, -74.3653 4.3340)',
        4326
    )
);

-- pontos 360
DROP TABLE IF EXISTS fusa_panos_360;
CREATE TABLE fusa_panos_360 (
    id SERIAL PRIMARY KEY,
    predio_id INT REFERENCES fusa_predios(id) ON DELETE SET NULL,
    titulo TEXT,
    url_pano TEXT,
    geom geometry(Point, 4326) NOT NULL
);

INSERT INTO fusa_panos_360 (predio_id, titulo, url_pano, geom)
VALUES (
    1,
    'Ponto 360 entrada',
    'http://fusa-assets:80/assets/fotos360/pano_0001.jpg',
    ST_SetSRID(ST_MakePoint(-74.3653, 4.3373), 4326)
);
