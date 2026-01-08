package com.example.demo;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BillRepository extends JpaRepository<Bean_Bill, Long> {

    List<Bean_Bill> findByBillNo(String billNo);

}
