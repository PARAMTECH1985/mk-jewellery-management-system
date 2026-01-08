package com.example.demo;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
public class GlobalRate {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double goldRate;
    private Double silverRate;

    private LocalDateTime updatedAt;

   

    // getters setters
    public Double getGoldRate() { return goldRate; }
    public void setGoldRate(Double goldRate) { this.goldRate = goldRate; }

    public Double getSilverRate() { return silverRate; }
    public void setSilverRate(Double silverRate) { this.silverRate = silverRate; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
