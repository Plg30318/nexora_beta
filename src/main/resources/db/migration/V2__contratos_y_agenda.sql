CREATE TABLE contrato (
  id BIGSERIAL PRIMARY KEY,
  cliente_id BIGINT NOT NULL REFERENCES cliente(id),
  cuba_id BIGINT NOT NULL REFERENCES cuba(id),
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  auto_renovacion BOOLEAN NOT NULL DEFAULT FALSE,
  prioridad SMALLINT NOT NULL DEFAULT 0 CHECK (prioridad BETWEEN 0 AND 5),
  estado TEXT NOT NULL CHECK (estado IN ('ACTIVO','VENCIDO','CANCELADO'))
);
CREATE INDEX idx_contrato_fin ON contrato (fecha_fin);
CREATE INDEX idx_contrato_cliente ON contrato (cliente_id);
CREATE UNIQUE INDEX uq_contrato_cuba_activo ON contrato(cuba_id) WHERE estado='ACTIVO';

CREATE TABLE agenda_recogida (
  id BIGSERIAL PRIMARY KEY,
  contrato_id BIGINT NOT NULL REFERENCES contrato(id),
  fecha TIMESTAMPTZ NOT NULL,
  estado TEXT NOT NULL CHECK (estado IN ('PENDIENTE','REALIZADA','CANCELADA')),
  notas TEXT
);
CREATE INDEX idx_agenda_fecha ON agenda_recogida (fecha);
