package com.example.demo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class BillItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;          // 22K Gold Necklace
    private String designCode;    // optional
    private String type;          // Gold / Silver
    private String purity;        // 22K / 925

    private Double grossWeight;
    private Double netWeight;

    private Double rate;          // per gram
    private Integer quantity;

    private Double amount;

    @ManyToOne
    @JoinColumn(name = "bill_id")
    private Bean_Bill bill;

    // getters setters
}
