package com.example.demo;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class BillServiceImpl implements BillService {

    private final BillRepository repo;
    private final GlobalRateRepository rateRepo;

    public BillServiceImpl(BillRepository repo, GlobalRateRepository rateRepo) {
        this.repo = repo;
        this.rateRepo = rateRepo;
    }
    
    @Override
    public List<Bean_Bill> findByBillNo(String billNo) {
        return repo.findByBillNo(billNo);
    }

    @Override
    public Bean_Bill saveBill(Bean_Bill bill) {

        GlobalRate globalRate = rateRepo.findAll()
                                        .stream()
                                        .findFirst()
                                        .orElse(null);

        if (globalRate != null && bill.getRate() != null) {

            List<Double> updatedRates = bill.getRate();

            for (int i = 0; i < updatedRates.size(); i++) {

                if ("Gold".equalsIgnoreCase(bill.getDescription())) {
                    updatedRates.set(i, globalRate.getGoldRate());
                }
                else if ("Silver".equalsIgnoreCase(bill.getDescription())) {
                    updatedRates.set(i, globalRate.getSilverRate());
                }
            }

            bill.setRate(updatedRates);
        }

        return repo.save(bill);
    }

    
    
    @Override
    public List<Bean_Bill> getAllBills() {
        return repo.findAll();
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
