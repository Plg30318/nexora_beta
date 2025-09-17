CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE IF NOT EXISTS camion (
  id BIGSERIAL PRIMARY KEY,
  matricula TEXT UNIQUE NOT NULL,
  activo BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS posicion_camion (
  id            BIGSERIAL PRIMARY KEY,
  camion_id     BIGINT NOT NULL,
  geom          GEOGRAPHY(Point,4326) NOT NULL,
  velocidad_kmh NUMERIC(6,2),
  carga_kg      NUMERIC(10,2),
  heading       NUMERIC(6,2),
  ts            TIMESTAMPTZ NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_pos_camion_geom ON posicion_camion USING GIST (geom);
CREATE INDEX IF NOT EXISTS idx_pos_camion_time ON posicion_camion (camion_id, ts DESC);
