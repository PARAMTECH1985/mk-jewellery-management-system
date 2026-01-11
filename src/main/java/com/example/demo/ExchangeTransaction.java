package com.example.demo;

import java.time.LocalDate;
import jakarta.persistence.*;

@Entity
@Table(name = "exchange_transaction")
public class ExchangeTransaction {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "bill_id", referencedColumnName = "id", insertable = false, updatable = false)
    private Bean_Bill bill;

    public Bean_Bill getBill() { return bill; }
    public void setBill(Bean_Bill bill) { this.bill = bill; }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="bill_id")
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
    private String newPurity;
    private Double newRate;
    private Double newValue;

    private Double balanceAmount;

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

    public Double getOldRate() { return oldRate; }
    public void setOldRate(Double oldRate) { this.oldRate = oldRate; }

    public Double getOldValue() { return oldValue; }
    public void setOldValue(Double oldValue) { this.oldValue = oldValue; }

    public String getNewDescription() { return newDescription; }
    public void setNewDescription(String newDescription) { this.newDescription = newDescription; }

    public Double getNewWeight() { return newWeight; }
    public void setNewWeight(Double newWeight) { this.newWeight = newWeight; }

    public String getNewPurity() { return newPurity; }
    public void setNewPurity(String newPurity) { this.newPurity = newPurity; }

    public Double getNewRate() { return newRate; }
    public void setNewRate(Double newRate) { this.newRate = newRate; }

    public Double getNewValue() { return newValue; }
    public void setNewValue(Double newValue) { this.newValue = newValue; }

    public Double getBalanceAmount() { return balanceAmount; }
    public void setBalanceAmount(Double balanceAmount) { this.balanceAmount = balanceAmount; }
}
