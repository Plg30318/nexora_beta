package com.smartcubasllopis.telemetria;

import jakarta.persistence.*;

@Entity
@Table(name = "posicion_camion")
public class PosicionCamionStub {
  @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
}
