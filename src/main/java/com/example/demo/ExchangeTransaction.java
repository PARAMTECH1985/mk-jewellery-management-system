package com.example.demo;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
public class ExchangeTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long billId;
    private String exchangeType;
    private LocalDate exchangeDate;

    // OLD
    private String oldDescription;
    private Double oldWeight;
    private String oldPurity;
    private Double oldRate;
    private Double oldValue;

    // NEW
    private String newDescription;
    private Double newWeight;
    private Double newRate;
    private Double newValue;

    private Double balanceAmount;

    // getters setters


    // ================= GETTERS / SETTERS =================

    public Long getId() { return id; }

    public Long getBillId() { return billId; }
    public void setBillId(Long billId) { this.billId = billId; }

    public String getExchangeType() { return exchangeType; }
    public void setExchangeType(String exchangeType) { this.exchangeType = exchangeType; }

    public LocalDate getExchangeDate() { return exchangeDate; }
    public void setExchangeDate(LocalDate exchangeDate) { this.exchangeDate = exchangeDate; }

    public String getOldDescription() { return oldDescription; }
    public void setOldDescription(String oldDescription) { this.oldDescription = oldDescription; }

    public Double getOldWeight() { return oldWeight; }
    public void setOldWeight(Double oldWeight) { this.oldWeight = oldWeight; }

    public String getOldPurity() { return oldPurity; }
    public void setOldPurity(String oldPurity) { this.oldPurity = oldPurity; }

    public Double getOldValue() { return oldValue; }
    public void setOldValue(Double oldValue) { this.oldValue = oldValue; }

    public String getNewDescription() { return newDescription; }
    public void setNewDescription(String newDescription) { this.newDescription = newDescription; }

    public Double getNewWeight() { return newWeight; }
    public void setNewWeight(Double newWeight) { this.newWeight = newWeight; }

    public Double getNewRate() { return newRate; }
    public void setNewRate(Double newRate) { this.newRate = newRate; }

    public Double getNewValue() { return newValue; }
    public void setNewValue(Double newValue) { this.newValue = newValue; }

    public Double getBalanceAmount() { return balanceAmount; }
    public void setBalanceAmount(Double balanceAmount) { this.balanceAmount = balanceAmount; }
    
    
    public Double getOldRate() {
        return oldRate;
    }

    public void setOldRate(Double oldRate) {
        this.oldRate = oldRate;
    }

}
