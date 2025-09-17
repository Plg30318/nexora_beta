-- Posiciones de camión (telemetría)
-- (Extensiones PostGIS ya se activan en V1)

CREATE TABLE IF NOT EXISTS posicion_camion (
  id            BIGSERIAL PRIMARY KEY,
  camion_id     BIGINT NOT NULL REFERENCES camion(id),
  geom          GEOGRAPHY(Point,4326) NOT NULL,
  velocidad_kmh NUMERIC(6,2),
  carga_kg      NUMERIC(10,2),            -- si NO la quieres, bórrala aquí
  heading       NUMERIC(6,2),
  ts            TIMESTAMPTZ NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_pos_camion_geom ON posicion_camion USING GIST (geom);
CREATE INDEX IF NOT EXISTS idx_pos_camion_time ON posicion_camion (camion_id, ts DESC);
