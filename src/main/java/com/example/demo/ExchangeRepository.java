package com.example.demo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExchangeRepository
        extends JpaRepository<ExchangeTransaction, Long> {

    List<ExchangeTransaction> findByBillId(Long billId);
    
    // optional (agar value > 0 wale hi chahiye)
    List<ExchangeTransaction> findByBillIdAndOldValueGreaterThan(Long billId, double value);

    // saara data (sab users ka)
    List<ExchangeTransaction> findAll();

    //  agar sirf valid value wale chahiye
    List<ExchangeTransaction> findByOldValueGreaterThan(double value);

}
