package com.example.demo;

import java.util.List;

public interface BillService {
    Bean_Bill saveBill(Bean_Bill bill);
    List<Bean_Bill> getAllBills();
    void deleteById(Long id);
    Bean_Bill getBillById(Long id);
    List<Bean_Bill> findByBillNo(String billNo);
}
