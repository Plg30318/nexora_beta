-- Zonas restringidas y parámetros de empresa

CREATE TABLE zona_restringida (
  id        BIGSERIAL PRIMARY KEY,
  nombre    TEXT NOT NULL,
  geom      GEOGRAPHY(Polygon,4326) NOT NULL,
  motivo    TEXT
);
CREATE INDEX idx_zona_geom ON zona_restringida USING GIST (geom);

CREATE TABLE parametro_empresa (
  clave   TEXT PRIMARY KEY,
  valor   JSONB NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
