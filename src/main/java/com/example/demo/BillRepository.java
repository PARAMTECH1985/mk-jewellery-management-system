package com.example.demo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface BillRepository extends JpaRepository<Bean_Bill, Long> {

    List<Bean_Bill> findByBillNo(String billNo);
    
    @Query("SELECT MAX(b.billNo) FROM Bean_Bill b")
    String findMaxBillNo();

}
