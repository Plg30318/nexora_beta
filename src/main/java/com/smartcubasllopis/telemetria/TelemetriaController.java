package com.smartcubasllopis.telemetria;

import jakarta.validation.constraints.*;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.OffsetDateTime;

@RestController
@RequestMapping("/api/v1/telemetria")
public class TelemetriaController {

  private final PosicionCamionRepository posRepo;

  public TelemetriaController(PosicionCamionRepository posRepo) {
    this.posRepo = posRepo;
  }

  public static record TelemetriaReq(
      @NotNull Long camionId,
      @NotNull @DecimalMin("-90.0") @DecimalMax("90.0") Double lat,
      @NotNull @DecimalMin("-180.0") @DecimalMax("180.0") Double lon,
      Double velocidadKmh,
      Double cargaKg,
      Double heading,
      @NotNull OffsetDateTime ts
  ) {}

  @PostMapping
  @Transactional
  public ResponseEntity<?> publicar(@RequestBody TelemetriaReq req) {
    int n = posRepo.insertar(
        req.camionId(),
        req.lat(), req.lon(),
        req.velocidadKmh(), req.cargaKg(), req.heading(),
        req.ts()
    );
    return (n == 1) ? ResponseEntity.accepted().build()
                    : ResponseEntity.internalServerError().build();
  }
}
