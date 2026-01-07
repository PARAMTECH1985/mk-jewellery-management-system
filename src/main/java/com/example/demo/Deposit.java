package com.example.demo;

import java.sql.Date;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Embeddable
public class Deposit {

	 private Double amount;
	    private LocalDate depositDate;

	    public Double getAmount() {
	        return amount;
	    }

	    public void setAmount(Double amount) {
	        this.amount = amount;
	    }

	    public LocalDate getDepositDate() {
	        return depositDate;
	    }

	    public void setDepositDate(LocalDate depositDate) {
	        this.depositDate = depositDate;
	    }
}
