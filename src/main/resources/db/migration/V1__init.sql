-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS citext;

-- Usuarios / Clientes / Camiones / Cubas (modelo básico)

CREATE TABLE usuario (
  id            BIGSERIAL PRIMARY KEY,
  email         CITEXT UNIQUE NOT NULL,
  password_hash TEXT        NOT NULL,
  nombre        TEXT,
  apellidos     TEXT,
  rol           TEXT NOT NULL CHECK (rol IN ('ROLE_ADMIN','ROLE_OPERACIONES','ROLE_CONDUCTOR')),
  activo        BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE cliente (
  id         BIGSERIAL PRIMARY KEY,
  nombre     TEXT NOT NULL,
  nif        TEXT,
  email      CITEXT,
  telefono   TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE camion (
  id         BIGSERIAL PRIMARY KEY,
  matricula  TEXT UNIQUE NOT NULL,
  activo     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE cuba (
  id         BIGSERIAL PRIMARY KEY,
  codigo     TEXT UNIQUE NOT NULL,
  geom       GEOGRAPHY(Point,4326) NOT NULL,
  estado     TEXT NOT NULL CHECK (estado IN ('CONTRATO_ACTIVO','VENCIDO','ABANDONO_SOSPECHADO')),
  bloqueada  BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_cuba_geom ON cuba USING GIST (geom);
