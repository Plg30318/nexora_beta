package com.smartcubasllopis.telemetria;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.OffsetDateTime;

@Repository
public interface PosicionCamionRepository extends CrudRepository<PosicionCamionStub, Long> {

  @Modifying @Transactional
  @Query(value = """
    INSERT INTO posicion_camion (camion_id, geom, velocidad_kmh, carga_kg, heading, ts)
    VALUES (
      :camionId,
      ST_SetSRID(ST_MakePoint(:lon, :lat), 4326)::geography,
      :velocidadKmh, :cargaKg, :heading, :ts
    )
    """, nativeQuery = true)
  int insertar(Long camionId, double lat, double lon,
               Double velocidadKmh, Double cargaKg, Double heading,
               OffsetDateTime ts);
}
