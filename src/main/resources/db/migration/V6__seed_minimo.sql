-- Parámetros por defecto
INSERT INTO parametro_empresa (clave, valor)
VALUES
  ('PROXIMIDAD_RADIO_M',  '250'::jsonb),
  ('MAX_VELOCIDAD_KMH_NOTIF', '30'::jsonb),
  ('SCORING_PESOS', '{"w1":1.0,"w2":2.0,"w3":1.5,"w4":1.0}'),
  ('LOCK_TTL_S', '120'::jsonb),
  ('VENTANA_PLANIFICACION_H', '6'::jsonb)
ON CONFLICT (clave) DO NOTHING;

-- Usuario admin por defecto
INSERT INTO usuario (email, password_hash, nombre, rol, activo)
VALUES (
  'admin@llopis.local',
  '$2a$10$7a9E1oQhX2X0yZ6r9eJkUe7V7mO8Q1n1i9wI8E0yDk0uQwWQkQy1y', -- admin
  'Admin',
  'ROLE_ADMIN',
  TRUE
)
ON CONFLICT (email) DO NOTHING;
