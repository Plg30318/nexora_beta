-- Oportunidades y Ordenes de recogida

CREATE TABLE oportunidad_recogida (
  id              BIGSERIAL PRIMARY KEY,
  cliente_id      BIGINT REFERENCES cliente(id),
  cuba_id         BIGINT REFERENCES cuba(id),
  geom            GEOGRAPHY(Point,4326),
  motivo          TEXT,                -- p.e. aviso de abandono, solicitud cliente, etc.
  prioridad       SMALLINT NOT NULL DEFAULT 0 CHECK (prioridad BETWEEN 0 AND 5),
  estado          TEXT NOT NULL DEFAULT 'ABIERTA' CHECK (estado IN ('ABIERTA','EN_CURSO','CERRADA','DESCARTADA')),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_oport_estado ON oportunidad_recogida (estado);
CREATE INDEX idx_oport_geom   ON oportunidad_recogida USING GIST (geom);

CREATE TABLE orden_recogida (
  id              BIGSERIAL PRIMARY KEY,
  oportunidad_id  BIGINT REFERENCES oportunidad_recogida(id),
  agenda_id       BIGINT REFERENCES agenda_recogida(id),
  camion_id       BIGINT REFERENCES camion(id),
  estado          TEXT NOT NULL DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE','ASIGNADA','EN_RUTA','COMPLETADA','CANCELADA')),
  asignada_ts     TIMESTAMPTZ,
  completada_ts   TIMESTAMPTZ
);
CREATE INDEX idx_orden_estado  ON orden_recogida (estado);
CREATE INDEX idx_orden_camion  ON orden_recogida (camion_id);
