package com.example.demo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExchangeRepository
        extends JpaRepository<ExchangeTransaction, Long> {

    List<ExchangeTransaction> findByBillId(Long billId);
}
