package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BillNumberService {

	 @Autowired
	    private BillRepository billRepository;

	    public Bean_Bill saveBill(Bean_Bill bill) {

	        // 🔹 1. Last bill no nikalo
	        String lastBillNo = billRepository.findMaxBillNo();

	        int nextNo = 1;

	        // 🔹 2. Next bill no calculate karo
	        if (lastBillNo != null) {
	            nextNo = Integer.parseInt(lastBillNo) + 1;
	        }

	        // 🔹 3. Limit check
	        if (nextNo > 9999) {
	            throw new RuntimeException("Bill number limit exceeded");
	        }

	        // 🔹 4. 4-digit format me set karo
	        bill.setBillNo(String.format("%04d", nextNo));

	        // 🔹 5. Save bill
	        return billRepository.save(bill);
	    }
}
