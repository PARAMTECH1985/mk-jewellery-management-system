package com.example.demo;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class BillServiceImpl implements BillService {

	 private final BillRepository repo;

	    public BillServiceImpl(BillRepository repo) {
	        this.repo = repo;
	    }
	    
	   

		@Override
		public Bean_Bill saveBill(Bean_Bill bill) {
			
			
			return repo.save(bill);
		}

		@Override
		public List<Bean_Bill> getAllBills() {
			return repo.findAll();
		}

		public List<Bean_Bill> findByBillNo(String billNo) {
		
			return repo.findByBillNo(billNo);
		}
		
		
		
		@Override
		public void deleteById(Long id) {
		    repo.deleteById(id);
		}

		
		@Override
		public Bean_Bill getBillById(Long id) {
		    return repo.findById(id).orElse(null);
		}


	   }
